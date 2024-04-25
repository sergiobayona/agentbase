# frozen_string_literal: true

# The ActiveLLM module is the main namespace for the gem.
module ActiveLLM
  class Error < StandardError; end
  require 'active_llm/version'
  require 'active_llm/application'
  require 'active_llm/llm'

  class UnsupportedTypeError < ArgumentError; end
  class UnsupportedConstraintError < ArgumentError; end
end
