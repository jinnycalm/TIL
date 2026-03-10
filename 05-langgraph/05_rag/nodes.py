# nodes.py
from langchain.messages import HumanMessage
from langchain.chat_models import init_chat_model
from langgraph.graph import MessagesState
from tools import retrieve_blog_posts
from prompts import REWRITE_QUESTION_PROMPT, GENERATE_ANSWER_PROMPT

res_llm = init_chat_model('gpt-4.1', temperature=0)


def generate_query_or_respond(state: MessagesState):
    '''llm이 사용자 대화를 기반으로 바로 답변을 생성하거나,
    RAG를 위한 query를 결정'''
    tllm = res_llm.bind_tools([retrieve_blog_posts])
    res = tllm.invoke(state['messages'])
    # state['messages']: 지금까지 한 모든 대화 기록을 다 밀어넣는 것.

    return {'messages': [res]}


def rewrite_question(state: MessagesState):
    """사용자 질문을 재작성"""
    messages = state['messages']
    # TODO: 나중에 전체 맥락을 이해하고 질문을 정제하는 것으로 바꾸기

    # TODO: rewrite 는 총 2번만 하고, 그때까지 답이 안나오면, 기본모델로 답변 생성하기

    question = messages[0].content
    prompt = REWRITE_QUESTION_PROMPT.format(original_question=question)
    response = res_llm.invoke(prompt)
    # HumanMessage(content=prompt)

    # AI"다시 query를 작성해야 한다" -> HumanMessage로 택갈이
    return {'messages': [HumanMessage(content=response.content)]}


def generate_answer(state: MessagesState):
    """최종 답변 생성"""
    question = state['messages'][0].content  # 원본 질문
    docs = state['messages'][-1].content  # 마지막 RAG docs
    prompt = GENERATE_ANSWER_PROMPT.format(question=question, docs=docs)
    res = res_llm.invoke(prompt)
    return {'messages': [res]}
    # res 자체가 AI Message임 마우스 올려보면 나옴.