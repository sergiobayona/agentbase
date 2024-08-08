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
    end
  end
end
