Workflow

Describes a set of user/system/llm-assistants interactions that are required to achieve a specific goal. A workflow is a sequence of steps that are executed in a specific order. Workflows can be simple or complex, depending on the goal and the number of steps required to achieve it.

Example:
A user wants to check the shipping status of an order. The workflow for this scenario would involve the user asking for the status of their order, providing the order number, and the system assistant retrieving the order information based on the order number provided by the user.

Scenario:
A user wants to check the shipping status of an order.

User message: "What is the status of my order?"
LLM response: "Please provide me with your order number."
User message: "123456"
LLM response: "Your order is currently being processed and will be shipped within 24 hours."


Worflow:
1. User asks for the status of their order.
2. LLM asks for the order number.
3. User provides the order number.
4. LLM provides the status of the order.


Actors:
- System assistant: Receives and processes user requests.
- User: Initiates the workflow by asking for the status of their order.
- Backend system: Provides the order information based on the order number provided by the user. Responds in JSON.


System assistant:
- Receives the user's request.
- Asks for the order number.
- With the order number provided, retrieves the status of the order using a function call to the backend system.
