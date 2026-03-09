# graph.py
from dotenv import load_dotenv
load_dotenv()
from langgraph.graph import StateGraph, START, END, MessagesState
from langgraph.prebuilt import ToolNode, tools_condition
from nodes import generate_answer, rewrite_question, generate_query_or_respond
from routers import grade_document
from tools import retrieve_blog_posts



workflow = StateGraph(MessagesState)

workflow.add_node('generate_query_or_respond', generate_query_or_respond)
workflow.add_node(rewrite_question) # 위랑 같은 것.
workflow.add_node(generate_answer)
# 노드지만, 단순히 tool 함수 실행만 할 경우 편함(굳이 wrapper node 만들지 않아도 됨)
workflow.add_node('retrieve',ToolNode([retrieve_blog_posts])) 

workflow.add_edge(START, 'generate_query_or_respond')

workflow.add_conditional_edges(
    'generate_query_or_respond', # 시작
    tools_condition, # 앞선 노드에서 tool 사용을 하냐마냐에 따라 자동결정
    {
        'tools': 'retrieve', # tools_condition은 항상 `tools`혹은 `__end__`로 결정남.
        '__end__': END
    }
)

workflow.add_conditional_edges(
    'retrieve',
    grade_document,
    # key-value가 동일한 경우 그냥 안써도 됨.
    {
        'generate_answer': 'generate_answer',
        'rewrite_question': 'rewrite_question'
    }
)

workflow.add_edge('rewrite_question', 'generate_query_or_respond')
workflow.add_edge('generate_answer', END)
graph = workflow.compile()
