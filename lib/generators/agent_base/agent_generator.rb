# lib/generators/agent_base/agent_generator.rb

module AgentBase
  class AgentGenerator < Rails::Generators::NamedBase
    source_root File.expand_path('templates', __dir__)

    def create_agent_file
      template 'agent.rb', File.join('app/agents', class_path, "#{file_name}.rb")
    end

    private

    def file_name
      @_file_name ||= remove_possible_suffix(super)
    end

    def remove_possible_suffix(name)
      name.sub(/(Agent|Assistant)$/, '')
    end

    def agent_name
      file_name.underscore
    end

    def agent_title
      "#{class_name.titleize} Assistant"
    end

    def agent_instructions
      "You are a #{file_name.humanize.downcase} assistant. Use the tools provided to assist with #{file_name.humanize.downcase}-related tasks."
    end
  end
end
