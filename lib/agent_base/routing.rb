module AgentBase
  Route = Data.define(:description, :options)

  class Routing
    attr_reader :routes

    alias all routes

    def initialize
      @routes = {}
    end

    def route(description, **options)
      raise ArgumentError, 'description must be a string' unless description.is_a?(String)
      raise ArgumentError, 'options must be a hash' unless options.is_a?(Hash)

      name = description.squeeze.downcase.gsub(' ', '_')
      @routes[name] = Route.new(description:, options:)
    end

    def [](name)
      all[name]
    end

    class << self
      attr_accessor :source

      def draw(&block)
        route_definitions = new
        route_definitions.instance_eval(&block)
        route_definitions
      end
    end
  end
end
