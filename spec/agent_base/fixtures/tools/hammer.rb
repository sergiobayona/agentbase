# frozen_string_literal: true
#require "ostruct"

module AgentBase::Tools
  class Hammer < Base

    def show
      """display an instance of a hammer"""

      @hammer = OpenStruct.new(name: 'Hammer', weight: 2.5, material: 'steel')
    end

  end
end
