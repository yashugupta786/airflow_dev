from fastapi import FastAPI
from pydantic import BaseModel
from agent import graph

app = FastAPI()

# Define input format
class UserInput(BaseModel):
    message: str

@app.post("/chat")
async def chat_with_agent(user_input: UserInput):
    try:
        stream = graph.stream({"messages": [{"role": "user", "content": user_input.message}]})
        final_response = None
        for event in stream:
            for value in event.values():
                final_response = value["messages"][-1].content
        return {"response": final_response}
    except Exception as e:
        return {"error": str(e)}
