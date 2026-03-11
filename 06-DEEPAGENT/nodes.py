# nodes.py

from state import State
from backend import dt_backend
import requests

def upload(state: State):

    print('----------')
    print(state)
    print('----------')
    files = state['files']


    for file in files:
        # 다운 로드
        d = requests.get(file['link'])
        # b_file = # download file -> file 바이너리 변환
        # 파일 업로드 이후 파일 저장된 위치를 변수에 넣음
        dt_backend.upload_files(
            [
                (f'/home/daytona/data/{file['name']}.csv', '파일 바이너리')
            ]
        )
    
    # dt_backend.upload_files(
    #     [
    #         ('/home/daytona/data/sales_data.csv', csv_bytes)
    #     ]
    # )

    return {'upload_paths': '샌드박스에 저장된 파일 위치 목록'}