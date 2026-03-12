from daytona import Daytona
from langchain_daytona import DaytonaSandbox
import time

daytona = Daytona()
boxes = daytona.list().items

sandbox = None

if boxes:
    # 1. 실행 중인 샌드박스 찾기
    running_boxes = [b for b in boxes if b.state == "Running"]
    
    if running_boxes:
        sandbox = running_boxes[0]
        print(f"✅ 기존에 돌아가던 샌드박스 사용 중 (ID: {sandbox.id})")
    else:
        # 2. 꺼져 있는 첫 번째 샌드박스 가져오기
        sandbox = boxes[0]
        print(f"💤 샌드박스가 꺼져 있어 다시 시작합니다... (ID: {sandbox.id})")
        
        # [수정 포인트] sandbox.id(문자열)가 아니라 sandbox 객체 자체를 전달해야 합니다.
        daytona.start(sandbox) 
        
        # 시작될 때까지 대기
        for _ in range(15):
            sandbox = daytona.get(sandbox.id)
            if sandbox.state == "Running":
                print("✨ 샌드박스 재시작 완료!")
                break
            time.sleep(1)
else:
    # 3. 아예 없으면 새로 생성
    print("🚀 샌드박스가 하나도 없어서 새로 생성합니다...")
    sandbox = daytona.create()
    # (이하 대기 로직 생략...)

dt_backend = DaytonaSandbox(sandbox=sandbox)