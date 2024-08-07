module AgentBase
  module Models
    extend ActiveSupport::Autoload

    autoload :Base

    class << self
      attr_accessor :source

      def load_models
        Dir.glob("#{source}/*.rb").each do |file|
          require file
        end
      end
    end
  end
end
