module AgentBase
  module Tools
    extend ActiveSupport::Autoload

    autoload :Base

    class << self
      attr_accessor :source

      def load
        Dir.glob("#{source}/*.rb").each do |file|
          super file
        end
      end

      def has_setup?
        constants.include?(:Setup)
      end
    end
  end
end
