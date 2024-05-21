# frozen_string_literal: true

module ActiveAI
  class User < Provider::Base
    PROMPT = <<-PROMPT
      creates a new user record in the database
    PROMPT
    def self.create(prompt = PROMPT)
      puts prompt
    end
  end
end
