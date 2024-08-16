require 'spec_helper'
require_relative '../../../../lib/generators/agent_base/agent_generator'

RSpec.describe AgentBase::AgentGenerator, type: :generator do
  destination File.expand_path('../../../../tmp', __dir__)

  before do
    prepare_destination
  end

  context 'when AgentBase is not installed' do
    pending 'raises an error' do
      expect do
        run_generator %w[Customer]
      end.to raise_error(Thor::Error, "AgentBase installation not found. Please run 'rails generate agent_base:install' first.")
    end
  end

  context 'when AgentBase is installed' do
    before do
      FileUtils.mkdir_p(File.join(destination_root, 'config'))
      FileUtils.touch(File.join(destination_root, 'config', 'agents.rb'))
    end

    context 'with a simple name' do
      before do
        run_generator %w[Customer]
      end

      pending 'creates the agent file' do
        assert_file 'app/agents/customer_agent.rb'
      end

      pending 'creates the agent with correct content' do
        assert_file 'app/agents/customer_agent.rb' do |content|
          assert_match(/class CustomerAgent < AgentBase::Agent/, content)
          assert_match(/name 'customer_assistant'/, content)
          assert_match(/title 'Customer Assistant'/, content)
          assert_match(/instructions 'You are a customer assistant. Use the tools provided to assist with customer-related tasks.'/, content)
          assert_match(/toolset %i\[communication management feedback\]/, content)
        end
      end
    end

    context 'with a namespaced name' do
      before do
        run_generator %w[Customer]
      end

      pending 'creates the agent file in the correct directory' do
        assert_file 'app/agents/support/customer_agent.rb'
      end

      pending 'creates the agent with correct namespacing and content' do
        assert_file 'app/agents/support/customer_agent.rb' do |content|
          assert_match(/module Support/, content)
          assert_match(/class CustomerAgent < AgentBase::Agent/, content)
          assert_match(/name 'customer_assistant'/, content)
          assert_match(/title 'Customer Assistant'/, content)
          assert_match(/instructions 'You are a customer assistant. Use the tools provided to assist with customer-related tasks.'/, content)
          assert_match(/toolset %i\[communication management feedback\]/, content)
        end
      end
    end

    context "with 'Agent' already in the name" do
      before do
        run_generator %w[CustomerAgent]
      end

      it "does not duplicate 'Agent' in the class name" do
        assert_file 'app/agents/customer_agent.rb' do |content|
          assert_match(/class CustomerAgent < AgentBase::Agent/, content)
          assert_no_match(/class CustomerAgentAgent < AgentBase::Agent/, content)
        end
      end
    end

    context 'with a complex name' do
      before do
        run_generator %w[AI::Support::CustomerServiceRepresentative]
      end

      pending 'creates the agent file in the correct directory' do
        assert_file 'app/agents/ai/support/customer_service_representative_agent.rb'
      end

      pending 'creates the agent with correct namespacing and content' do
        assert_file 'app/agents/ai/support/customer_service_representative_agent.rb' do |content|
          assert_match(/module AI/, content)
          assert_match(/module Support/, content)
          assert_match(/class CustomerServiceRepresentativeAgent < AgentBase::Agent/, content)
          assert_match(/name 'customer_service_representative_assistant'/, content)
          assert_match(/title 'Customer Service Representative Assistant'/, content)
          assert_match(/instructions 'You are a customer service representative assistant. Use the tools provided to assist with customer service representative-related tasks.'/, content)
          assert_match(/toolset %i\[communication management feedback\]/, content)
        end
      end
    end
  end
end
