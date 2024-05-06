ActiveAI Routing Workflow

This document describes the components and interactions between the routing system, the LLM and the User. The routing system is responsible for routing requests.

Routing Table:
The routing table has similarities to the Rails routing system. It is stored in the main Rails application at app/active_ai/config/routes.rb. The routing table contains a list of routes. Each route has a path, a controller name, an action name, a set of parameters and a set of phrases. The routing table is loaded into memory when the Rails application starts up.

Example of a routing definition:

```ruby
ActiveAI::Router.routes.draw do
  route path: '/user/id',
        controller: 'user',
        action: 'show',
        parameters: { id: :id },
        phrasing: ['Show user with id :id', 'My id is :id', 'I am user :id']
  route path: '/user/email',
        controller: 'user',
        action: 'show',
        parameters: { email: :email },
        phrasing: ['Show user with email :email', 'My email is :email', 'I am user :email']
  route path: '/user/email/authenticate',
        controller: 'user',
        action: 'authenticate',
        parameters: { email: :email },
        phrasing: ['Authenticate user with email :email', 'My email is :email']
end
```


Assumptions:
The LLM already has an routing table with the following routes:

User Routes:
1. Show user with id. Returns user object.
2. Show user with email. Returns user object.
3. Authenticate user with email. Returns true if user is authenticated.

Interactions:
user: I'm user Sergio Bayona with email bayona.sergio@gmail.com
llm: identifies request as "user related" and returns function to find user by email:

"tool_calls": [
{
    "id": "call_id",
    "function": {
        "arguments": '{"class": "ActiveAI::User", "method": "find_user_by_email", "arguments": "[email_address]"}',
        "name": "find_user_by_email",
    },
    "type": "function",
}]

system: returns the user object if found
llm: welcomes user Sergio Bayona
llm: requests state of user session with function:
"tool_calls": [
{
    "id": "call_id",
    "function": {
        "arguments": '{"class": "ActiveAI::User", "method": "signed_in?", "arguments": "[email_address]"}',
        "name": "get_user_session_by_email",
    },
    "type": "function",
}]

system: returns false indicating the user is not signed in.
llm: decides to prompt user to sign-in. Message: We have send you an email with a link for your to sign-in. 
and calls function:

 {class: 'ActiveAI::User', method: 'send_signin_message', args: [user]}

 "tool_calls": [
{
    "id": "call_id",
    "function": {
        "arguments": '{"class": "ActiveAI::User", "method": "send_signin_message", "arguments": "[user]"}',
        "name": "send_signin_message",
    },
    "type": "function",
}]
user: receives an email with a special unique link to sign in. User clicks on the link and is signed in.
llm: requests state of user session with function.
system: returns true indicating the user is signed in.

