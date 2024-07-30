module AgentBase
  class Assistants
    extend ActiveSupport::Autoload

    def initialize
      @assistants = []
    end
  end
end
