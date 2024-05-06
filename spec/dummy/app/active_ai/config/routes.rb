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
