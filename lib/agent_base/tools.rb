module AgentBase
  module Tools
    extend ActiveSupport::Autoload

    autoload :Base

    class << self
      attr_accessor :source

      def load_tools
        Dir.glob("#{source}/*.rb").each do |file|
          load file
        end
      end
    end
  end
end
