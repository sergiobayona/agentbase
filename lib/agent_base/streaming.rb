require 'http-parser' # Make sure you have the http-parser gem installed
require 'json'

module Streaming
  class ResponseParser < HttpParser::Parser
    def initialize
      @buffer_tokenizer = BufferedTokenizer.new("\r")
      @current_stream = ''

      # self.on_message_complete = method(:on_headers_complete_callback)
      binding.pry
      on_message_complete do |ins|
        # binding.pry
        # method(:on_headers_complete_callback).call(ins)
        binding.pry
      end

      # self.on_body = method(:on_body_callback)
      on_body do |data|
        method(:on_body_callback).call(data)
      end
    end

    def on_http_success(&block)
      @http_success_callback = block
    end

    def on_http_error(&block)
      @http_error_callback = block
    end

    def on_each_line(&block)
      @each_line_callback = block
    end

    def on_parse_error(&block)
      @parse_error_callback = block
    end

    def on_headers_complete_callback(headers)
      @status_code = status_code.to_i
      if @status_code == 200
        execute_callback(@http_success_callback, 200)
      else
        execute_callback(@http_error_callback, @status_code)
      end
    end

    def on_body_callback(data)
      @buffer_tokenizer.extract(data).each do |line|
        parse_line(line)
      end
      @current_stream = ''
    rescue StandardError => e
      execute_callback(@parse_error_callback, e.to_s)
      nil
    end

    def parse_data(data)
      self << data
    rescue StandardError
      # handle parsing error
    end

    def parse_line(line)
      line_trimmed = line.strip

      if line_trimmed.empty?
        execute_callback(@parse_error_callback, 'Invalid JSON')
      elsif line_trimmed[0, 1] == '{' || line_trimmed[line_trimmed.length - 1, 1] == '}'
        @current_stream << line_trimmed
        if looks_like_json?(@current_stream)
          execute_callback(@each_line_callback, @current_stream)
          @current_stream = ''
        end
      else
        execute_callback(@parse_error_callback, 'Invalid JSON')
      end
    end

    def parse_unflushed_data
      parse_line(@buffer_tokenizer.flush)
    end

    def looks_like_json?(string)
      string[0, 1] == '{' && string[string.length - 1, 1] == '}'
    end

    def execute_callback(callback, *args)
      callback.call(*args) if callback
    end
  end
end
