module ActiveAI
  module Routing
    class Router
      class << self
        attr_accessor :route_source

        def routes
          @routes ||= Routes.new
        end

        def load_routes
          load route_source
        end

        def app_routes
          routes.routes
        end
      end
    end

    class Routes
      Route = Data.define(:path, :controller, :action, :parameters, :phrasing) do
        def name
          path.gsub('/', '_').sub('_', '')
        end
      end

      def initialize
        @routes = {}
      end

      def draw(&block)
        instance_eval(&block)
      end

      def route(**options)
        @routes[options[:path]] = Route.new(**options)
      end

      attr_reader :routes
    end
  end
end

ActiveAI::Router = ActiveAI::Routing::Router
ActiveAI::Routes = ActiveAI::Routing::Routes
