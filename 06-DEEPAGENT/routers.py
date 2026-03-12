# router.py
from state import State

def check_files(state: State):
    files = state.get('files', [])

    print(">>> [Router] Checking files:", files)

    if files:
        return 'upload'
    else:
        return 'deep_agent'