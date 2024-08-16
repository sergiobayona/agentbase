# frozen_string_literal: true

require 'ostruct'
class Hammer < AgentBase::ToolSet
  # Show the hammer.
  def show
    @hammer = OpenStruct.new(name: 'Hammer', weight: 2.5, material: 'steel')
  end

  # Find a hammer by name.
  # @param name [String] The name of the hammer to find.
  def find(name:)
    @hammer = OpenStruct.new(name:, weight: 2.5, material: 'steel')
  end

  # Smack something with the hammer.
  # Grab the hammer and smack something with it.
  # @param something [String] the thing to smack.
  # @param force [Integer] the force to smack with.
  def smack(something:, force: 1)
    @hammer = OpenStruct.new(name: 'Hammer', weight: 2.5, material: 'steel')
  end
end
