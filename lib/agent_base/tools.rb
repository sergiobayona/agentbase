module AgentBase
  module Tools
    extend ActiveSupport::Autoload

    autoload :Base
    autoload :Task

    class << self
      attr_accessor :source

      def load_tools
        Dir.glob("#{source}/*.rb").each do |file|
          load file
        end
      end

      def all
        # Get all the classes that are a subclass of Base
        # and are in the AgentBase::Tools namespace
        Base.descendants
      end

      def reset
        # Remove all the constants in the AgentBase::Tools namespace except for Base
        (AgentBase::Tools.constants - [:Base]).each { |const| remove_const(const) }
      end
    end
  end
end
