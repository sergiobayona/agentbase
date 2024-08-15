AgentBase

AgentBase is a Ruby library for building AI service agents. It facilitates the job of building agents (also called assistants) and their tools. AgentBase integrates with Ruby on Rails.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'agent_base'
```

And then execute:

```bash
bundle install
```

The run:

```bash
rails generate agent_base:install
```

This command will add a configuration file located at `config/agents.rb` and an empty `app/agents` folder. The configuration is used to specify the default settings used by the agents and their tools.

```ruby
## Usage

You can use the gem generator to create a basic skeleton for a new agent or create one manually.

### Generator Usage

To create a new agent using the generator, run the following command:

```bash
rails generate agent_base:agent Customer::Agent
```

This will create a new agent in the `app/agents` directory. The agent will have a basic structure with a title, instructions, and a toolset. You can add tools to the agent by running the following command:

```bash
rails generate agent_base:tool Customer::Agent management
```

### Manual Agent setup

You can also create a new agent manually by creating a new Ruby class in the `app/agents` directory. The agent class should inherit from `AgentBase::Agent` and define a title, instructions, and a toolset. Here is an example of a simple agent:

```ruby
# app/agents/customer/agent.rb
class Customer::Agent < AgentBase::Agent
  name  "customer_assistant"
  title "Customer Support Assistant"
  instructions "You are a customer assistant. Use the tools provided to answer the customer questions."
  toolset :communication, :management, :feedback
end
```

Place the agent tools in the same directory as the agent.rb file. Group sets of tools as classes that inherit inherit from `AgentBase::ToolSet`. Here is an example of a simple tool:

```ruby
# app/agents/customer/communication.rb
class Customer::Communication < AgentBase::ToolSet
  # Sends a welcome email to new users.
  # @param user_id [Integer] the id of the user to email.
  def send_welcome_email(user_id:)
    puts "Sending welcome email to customer..."
  end
end
```

Notice that the `send_welcome_email` is preceeded by a comment that describes the method and the parameters passed to the method (i.e. user_id). This has multiple purposes. It documents the method and it's used as output in console tool. But more importantly it's used internally to generate the tool's actions.

All action methods in a toolset class must contain a comment that describes the method or action and the parameters passed to the method. This is required for the correct operation of the agent.

### Method Comment Format

The first line of the comment should describe the method or action in plain words. The following lines should describe the parameters passed to the method. The comment should be formatted as follows:

Each parameter should be preceded by a `# @param` tag followed by the parameter name, the parameter type wrapped in square brackets (i.e [String]) and a definition of the parameter.
Each parameter should be on a separate line.
You can use all the standard Ruby types (i.e. String, Integer, Float, Array, Hash, etc.) as parameter types.

Here is an example of a well-formatted comment:

```ruby
# Locate a user by email address.
# @param email_address [String] The user email address.
def find_user(email_address:)
  # method implementation
end
```

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

List all agents:

```ruby
app.agents.all
=> [Customer::Agent]
app.agents.names
=> ["customer_assistant"]
```

Get the agent's details:

You can address the agent by its name:

```ruby
app.agents.customer_assistant.name
=> "customer_assistant"
```

You can also get the agent's title and instructions:

```ruby
app.agents.customer_assistant.title
=> "Customer Support Assistant"
app.agent.customer_assistant.instructions 
=> "You are a customer assistant. Use the tools provided to answer the customer questions."
```

Get the tools available to the agent:

```ruby
app.agents.customer_assistant.toolset
=> [:communication, :management, :feedback]
```

Checkout the tools actions:

```ruby
agent_tools = app.agents.customer_assistant.tools
agent_tools.communication.actions
=> [:welcome_email, :email_authentication, :sms_authentication]
```
