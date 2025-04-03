from typing import Annotated
from typing_extensions import TypedDict
from langgraph.graph import StateGraph, START, END
from langgraph.graph.message import add_messages
from langchain_ollama import ChatOllama

# Define the state
class State(TypedDict):
    messages: Annotated[list, add_messages]

# LangGraph builder
graph_builder = StateGraph(State)

# LLM setup
llm = ChatOllama(model="llama3:2.1b")

# Define node function
def chatbot(state: State) -> State:
    response = llm.invoke(state["messages"])
    return {"messages": [response]}

# Add nodes and edges
graph_builder.add_node("chatbot", chatbot)
graph_builder.add_edge(START, "chatbot")
graph_builder.add_edge("chatbot", END)

# Compile graph
graph = graph_builder.compile()
