# AgentBase

AgentBase is a Ruby library for building AI service agents. It simplifies the process of creating agents (also called assistants) and their tools. AgentBase integrates seamlessly with Ruby on Rails.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'agent_base'
```

Then execute:

```bash
bundle install
```

Next, run:

```bash
rails generate agent_base:install
```

This command will add a configuration file located at `config/agents.rb` and create an empty `app/agents` folder. The configuration file is used to specify the default settings for agents and their tools.

## Usage

You can use the gem generator to create a basic skeleton for a new agent or create one manually.

### Generator Usage

To create a new agent using the generator, run:

```bash
rails generate agent_base:agent CustomerSupport
```

This will create a new agent in the `app/agents` directory with a basic structure including a title, instructions, and a toolset.

To add tools to the agent, run:

```bash
rails generate agent_base:tool CustomerSupport management
```

### Manual Agent Setup

You can also create a new agent manually by creating a Ruby class in the `app/agents` directory. The agent class should inherit from `AgentBase::Agent` and define a name, title, instructions, and a toolset. Here's an example of a simple agent:

```ruby
# app/agents/customer/agent.rb
class Customer::Agent < AgentBase::Agent
  name "customer_assistant"
  title "Customer Support Assistant"
  instructions "You are a customer assistant. Use the provided tools to answer customer questions."
  toolset :communication, :management, :feedback
end
```

Place the agent tools in the same directory as the `agent.rb` file. Group sets of tools as classes that inherit from `AgentBase::ToolSet`. Here's an example of a simple tool:

```ruby
# app/agents/customer/communication.rb
class Customer::Communication < AgentBase::ToolSet
  # Sends a welcome email to new users.
  # @param user_id [Integer] The ID of the user to email.
  def send_welcome_email(user_id:)
    puts "Sending welcome email to customer..."
  end
end
```

Note that the `send_welcome_email` method is preceded by a comment describing the method and its parameters. This serves multiple purposes:
1. It documents the method.
2. It's used as output in the console tool.
3. It's used internally to generate the tool's actions.

All action methods in a toolset class must contain a comment that describes the method or action and its parameters. This is required for the correct operation of the agent.

### Method Comment Format

The first line of the comment should describe the method or action in plain words. The following lines should describe the parameters passed to the method. The comment should be formatted as follows:

- Each parameter should be preceded by a `@param` tag followed by the parameter name, the parameter type wrapped in square brackets, and a definition of the parameter.
- Each parameter should be on a separate line.
- You can use all standard Ruby types (e.g., String, Integer, Float, Array, Hash, etc.) as parameter types.

Here's an example of a well-formatted comment:

```ruby
# Locate a user by email address.
# @param email_address [String] The user's email address.
def find_user(email_address:)
  # method implementation
end
```

## Console Usage

Launch the console:

```bash
./bin/console
```

Create a new application:

```ruby
app = AgentBase::Application.new
=> #<AgentBase::Application:0x00000001383dd630>
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

app.agents.customer_assistant.instructions 
=> "You are a customer assistant. Use the provided tools to answer customer questions."
```

Get the tools available to the agent:

```ruby
app.agents.customer_assistant.toolset
=> [:communication, :management, :feedback]
```

Check out the tool's actions:

```ruby
agent_tools = app.agents.customer_assistant.tools
agent_tools.communication.actions
=> [:welcome_email, :email_authentication, :sms_authentication]
```