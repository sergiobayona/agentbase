require 'spec_helper'


RSpec.describe "Example Agent" do

  subject(:agent) do
    Class.new(AgentBase::Agent) do
      name 'ExampleAgent'
      title 'Example Agent'
      instructions 'I am an example agent. How can I help you?'
      toolset [:example_tool]
    end
  end

  let(:example_tool) do
    Class.new(AgentBase::Tool) do
      def self.name
        'ExampleTool'
      end
    end
  end

end
