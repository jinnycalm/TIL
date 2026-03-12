# app.py
from dotenv import load_dotenv
load_dotenv()

from nodes import upload
from deepagents import create_deep_agent
from tools import send_slack_message
from backend import dt_backend
from routers import check_files
from state import State

from langgraph.graph import START, END, StateGraph
def preprocess_prompt(state: State):
    paths = state.get('upload_paths', [])
    messages = state.get('messages', [])
    
    if messages:
        last_msg = messages[-1]
        path_info = "\n".join([f"- {p}" for p in paths]) if paths else "없음"
        
        instruction = (
            f"[시스템 안내]\n"
            f"1. 사용자가 보낸 파일은 Daytona 샌드박스의 다음 경로에 있습니다: {path_info}\n"
            f"2. 파일을 분석한 후, 답변은 반드시 'send_slack_message' 도구를 사용하여 전송하세요.\n"
            f"3. 도구를 사용하지 않으면 사용자가 답변을 볼 수 없습니다.\n\n"
        )
        
        last_msg.content = instruction + last_msg.content
        
    return {"messages": messages}

deep_agent = create_deep_agent(
    model='openai:gpt-5-mini',
    tools=[send_slack_message],
    backend=dt_backend,
)

workflow = StateGraph(State)

# 1. 노드 등록
workflow.add_node('upload', upload)
workflow.add_node('preprocess', preprocess_prompt) # 추가!
workflow.add_node('deep_agent', deep_agent)

# 2. 시작 조건 (루터) 연결
workflow.add_conditional_edges(
    START,
    check_files, # (upload_paths 있으면 deep_agent로 보냄)
    {
        'upload': 'upload',
        'deep_agent': 'preprocess', # 에이전트 가기 전에 전처리를 거치게 함!
    }
)

# 3. 노드 간 엣지 연결
workflow.add_edge('upload', 'preprocess')    # 업로드 끝나면 전처리로!
workflow.add_edge('preprocess', 'deep_agent') # 전처리 끝나면 에이전트로!
workflow.add_edge('deep_agent', END)


graph = workflow.compile()