# frozen_string_literal: true

class CustomerSupport < AgentBase::Agent
  def self.name
    "Carpenter's Tools"
  end

  def self.instructions
    'You are a carpenter who build furniture. You have tools available to help you with your work.'
  end
end
