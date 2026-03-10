from langgraph.graph import MessagesState

class State(MessagesState):
    # messages << 상속받았기 때문에 항상 있다.
    files: list
    upload_paths: list

'''
{
    'files': ['/a/b/c.csv', '/x/y/z.py'],
    'upload_paths': [
        'home/daytona/data/a.csv'
        'home/daytona/data/b.csv'
    ],
    'messages': [
        HumanMessage(content='hi'),
        AIMessage(conten='hello')
        ]
}
'''