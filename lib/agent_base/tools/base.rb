module AgentBase
  module Tools
    class Base
      def render(json: nil, template: nil)
        template ||= infer_template_name
        binding.pry
      end

      private

      def infer_template_name
        caller_locations(1, 1)[0].label
      end
    end
  end
end
