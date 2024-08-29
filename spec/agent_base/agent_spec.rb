require "spec_helper"

RSpec.describe AgentBase::Agent do
  let(:app_config) { double("AppConfig", model: "gpt-3.5-turbo") }

  let(:default_config) do
    {
      name: nil,
      title: nil,
      instructions: "I am an AI assistant. How can I help you?",
      toolset: [],
      model: nil
    }
  end

  describe "class-level configuration" do
    let(:test_agent_class) do
      hammer = class_double("Tool").as_stubbed_const
      Class.new(described_class) do
        name "test_agent"
        title "Test Agent"
        instructions "I am a test agent"
        toolset [hammer]
        model "gpt-4"
      end
    end

    it "allows setting and getting name" do
      expect(test_agent_class.name).to eq "test_agent"
    end

    it "allows setting and getting title" do
      expect(test_agent_class.title).to eq "Test Agent"
    end

    it "allows setting and getting instructions" do
      expect(test_agent_class.instructions).to eq "I am a test agent"
    end

    it "allows setting and getting toolset" do
      expect(test_agent_class.toolset).to be_a(Array)
    end

    it "allows setting and getting model" do
      expect(test_agent_class.model).to eq "gpt-4"
    end
  end

  describe "default values" do
    let(:default_agent_class) { Class.new(described_class) }

    it "uses class name as default name" do
      allow(default_agent_class).to receive(:to_s).and_return("TestAgent")
      expect(default_agent_class.name).to eq "test_agent"
    end

    it "uses humanized name as default title" do
      allow(default_agent_class).to receive(:name).and_return("test_agent")
      expect(default_agent_class.title).to eq "Test agent"
    end

    it "uses default instructions" do
      expect(default_agent_class.instructions).to eq default_config[
           :instructions
         ]
    end

    it "uses empty array as default toolset" do
      expect(default_agent_class.toolset).to eq []
    end

    it "uses nil as default model" do
      expect(default_agent_class.model).to be_nil
    end
  end

  describe "inheritance" do
    let(:parent_class) do
      Class.new(described_class) do
        name "parent_agent"
        instructions "I am a parent agent"
        toolset :parent_tool
      end
    end

    let(:child_class) do
      Class.new(parent_class) do
        title "Child Agent"
        toolset :child_tool
      end
    end

    it "inherits configuration from parent class" do
      expect(child_class.name).to eq "parent_agent"
      expect(child_class.instructions).to eq "I am a parent agent"
    end

    it "can override parent configuration" do
      expect(child_class.title).to eq "Child Agent"
      expect(child_class.toolset).to eq [:child_tool]
    end
  end

  describe "instance-level configuration" do
    let(:test_agent_class) do
      Class.new(described_class) do
        name "test_agent"
        title "Test Agent"
        instructions "I am a test agent"
        model "gpt-4"
      end
    end

    it "uses class-level configuration by default" do
      agent = test_agent_class.new(app_config)
      expect(agent.name).to eq "test_agent"
      expect(agent.title).to eq "Test Agent"
      expect(agent.instructions).to eq "I am a test agent"
      expect(agent.toolset).to be_a(AgentBase::ToolSet)
      expect(agent.model).to eq "gpt-4"
    end

    it "allows overriding configuration at instance level" do
      agent =
        test_agent_class.new(
          app_config,
          name: "custom_agent",
          title: "Custom Agent",
          instructions: "I am a custom agent",
          model: "gpt-3.5-turbo-16k"
        )
      expect(agent.name).to eq "custom_agent"
      expect(agent.title).to eq "Custom Agent"
      expect(agent.instructions).to eq "I am a custom agent"
      expect(agent.toolset.tools).to eq []
      expect(agent.model).to eq "gpt-3.5-turbo-16k"
    end

    it "uses app_config default model when no model is specified" do
      default_agent_class = Class.new(described_class)
      agent = default_agent_class.new(app_config)
      expect(agent.model).to eq "gpt-3.5-turbo"
    end
  end

  describe "application configuration" do
    let(:test_agent_class) { Class.new(described_class) }

    it "stores the application configuration" do
      agent = test_agent_class.new(app_config)
      expect(agent.app_config).to eq app_config
    end

    it "uses application default model when no model is specified" do
      agent = test_agent_class.new(app_config)
      expect(agent.model).to eq "gpt-3.5-turbo"
    end

    it "prefers class-level model over application default" do
      test_agent_class.model "gpt-4"
      agent = test_agent_class.new(app_config)
      expect(agent.model).to eq "gpt-4"
    end

    it "prefers instance-level model over class-level and application default" do
      test_agent_class.model "gpt-4"
      agent = test_agent_class.new(app_config, model: "gpt-3.5-turbo-16k")
      expect(agent.model).to eq "gpt-3.5-turbo-16k"
    end
  end

  describe "multiple instances" do
    let(:test_agent_class) { Class.new(described_class) }

    it "allows creation of multiple instances with different configurations" do
      agent1 =
        test_agent_class.new(app_config, name: "agent1", title: "Agent One")
      agent2 =
        test_agent_class.new(app_config, name: "agent2", title: "Agent Two")

      expect(agent1.name).to eq "agent1"
      expect(agent1.title).to eq "Agent One"
      expect(agent2.name).to eq "agent2"
      expect(agent2.title).to eq "Agent Two"
    end
  end
end
