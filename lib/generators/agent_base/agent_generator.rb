module AgentBase
  class AgentGenerator < Rails::Generators::NamedBase
    source_root File.expand_path('templates', __dir__)

    def check_installation
      return if File.exist?(Rails.root.join('config', 'agents.rb'))

      raise Thor::Error, "AgentBase installation not found. Please run 'rails generate agent_base:install' first."
    end

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
