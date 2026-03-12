import threading # 중복 ID 저장을 위해 추가
from fastapi import FastAPI, Request, BackgroundTasks
from app import graph
from langchain.messages import HumanMessage

app = FastAPI()

# 최근 처리한 event_id를 저장하는 세트 (간단한 중복 방지)
processed_event_ids = set()
# 세트가 너무 커지지 않도록 관리하는 락(Lock)
ids_lock = threading.Lock()

async def run_agent_in_background(text, files):
    try:
        await graph.ainvoke({
            'messages': [HumanMessage(content=text)],
            'files': files
        })
        print("에이전트 작업 완료")
    except Exception as e:
        print(f"에이전트 실행 중 오류 발생: {e}")

@app.post('/slack/webhook')
async def slack_webhook(req: Request, background_tasks: BackgroundTasks):
    # 1. 재시도 요청 무시
    if req.headers.get('X-Slack-Retry-Num'):
        return {'ok': True}

    payload = await req.json()
    
    # URL 검증
    if "challenge" in payload:
        return {"challenge": payload["challenge"]}

    # 2. 중복 이벤트 처리 방지 (event_id 체크)
    event_id = payload.get('event_id')
    with ids_lock:
        if event_id in processed_event_ids:
            print(f"중복된 event_id 무시: {event_id}")
            return {'ok': True}
        processed_event_ids.add(event_id)
        # 메모리 관리를 위해 최근 100개만 유지 (선택 사항)
        if len(processed_event_ids) > 100:
            processed_event_ids.pop()

    event = payload.get('event', {})
    
    # 3. 특정 이벤트 타입만 처리 (app_mention이나 message 중 하나만 선택)
    # 여기서는 'message' 타입이면서 봇이 아닌 경우만 처리하도록 필터링을 강화합니다.
    if event.get('bot_id') or event.get('subtype') == 'bot_message':
        return {'ok': True}

    # 만약 채널 멘션과 일반 메시지가 중복된다면, 아래처럼 타입을 고정할 수 있습니다.
    # if event.get('type') != 'app_mention': return {'ok': True}

    text = event.get('text', '')
    files_info = event.get('files', [])
    files = [{'name': f['name'], 'link': f['url_private_download']} for f in files_info]

    background_tasks.add_task(run_agent_in_background, text, files)
    
    return {'ok': True}