import os
import re
from state import State
from backend import dt_backend
import requests

def upload(state: State):
    print('--- Uploading Files to Daytona ---')
    files = state.get('files', [])
    uploaded_list = []

    # Get Slack token from environment
    slack_bot_token = os.environ.get('SLACK_BOT_TOKEN')
    if not slack_bot_token:
        print("Error: SLACK_BOT_TOKEN environment variable not set.")
        return {'upload_paths': []} # Exit gracefully

    headers = {'Authorization': f'Bearer {slack_bot_token}'}

    for file in files:
        try:
            # 1. 파일 다운로드 (With Auth)
            print(f"Downloading {file['name']} from {file['link']}...")
            response = requests.get(file['link'], headers=headers)
            response.raise_for_status() # Raise an error for bad status codes

            # 2. 파일 데이터 준비 (with Sanitization)
            file_name = file['name']
            # Sanitize the filename
            sanitized_name = re.sub(r'[^\w\._-]', '', file_name.replace(' ', '_'))
            
            target_path = f"/home/daytona/{sanitized_name}"
            file_binary = response.content

            # 3. Daytona 업로드 실행 (With logging)
            print(f"--- Attempting to upload to Daytona ---")
            print(f"    Sanitized Sandbox path: {target_path}")
            print(f"    Content type: {type(file_binary)}")
            print(f"    Content length: {len(file_binary)}")

            dt_backend.upload_files([
                (target_path, file_binary)
            ])
            
            uploaded_list.append(target_path)
            print(f"Success: {target_path} 업로드 완료")

        except requests.exceptions.HTTPError as http_err:
            print(f"HTTP Error during download: {http_err}")
            print(f"Response Body: {response.text}") # Print body for debugging
        except Exception as e:
            print(f"Exception during upload: {e}")

    # 리스트 형태로 반환 (State 덮어쓰기 방지)
    return {'upload_paths': uploaded_list}