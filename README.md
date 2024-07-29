AgentBase

AgentBase is a Ruby library for building intelligent agents. It provides a simple interface for defining tools and tasks that an agent would utilize. It integrates with Ruby on Rails.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'agent_base'
```

And then execute:

    $ bundle install

** Console Usage ** 

Launch the console:

``` bash
./bin/console
```

Crate a new application:
``` ruby
app = AgentBase::Application.new
=> #<AgentBase::Application:0x00000001383dd630
```

List all tools:

```ruby
app.tools.all
=> [AgentBase::Tools::User]
```

List all tasks for a given tool:

```ruby
app.tools.user.tasks
=> {:show=>#<AgentBase::Task:0x000000013f5d5648 @name=:show, @tool=AgentBase::Tools::User>, :create=>#<AgentBase::Task:0x000000013f5d5558 @name=:create, @tool=AgentBase::Tools::User>}

