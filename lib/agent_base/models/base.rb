module AgentBase
  module Models
    class Base
      def self.find(id)
        new
      end

      def save
        true
      end

      def errors
        []
      end
    end
  end
end
