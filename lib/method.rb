module MethodDescriptionExtractor
  def description
    source_code = source_location
    return nil unless source_code

    file_path, line_number = source_code
    lines = File.readlines(file_path, encoding: 'UTF-8')

    description_lines = []
    method_line = line_number - 1

    # Start from the line above the method definition and look upwards for comments
    (method_line - 1).downto(0) do |index|
      line = lines[index].strip
      # Break if an empty line or another method definition is encountered
      break if line.empty? || line.match?(/^def\s+/)

      # Skip YARD tags but don't clear previous comments
      next if line.match?(/^#\s*@/)

      # Capture and clean comment lines
      break unless line.start_with?('#')

      cleaned_line = line.sub(/^#\s?/, '') # Remove '#' and optional space
      description_lines.unshift(cleaned_line)

      # Stop if any non-comment, non-empty line is encountered
    end

    description = description_lines.join("\n").strip
    description.force_encoding('UTF-8') # Ensure UTF-8 encoding
    description
  end

  def params
    source_code = source_location
    return nil unless source_code

    file_path, line_number = source_code
    lines = File.readlines(file_path, encoding: 'UTF-8')

    params = []
    method_line = line_number - 1

    # Look for @param tags in the comments above the method definition
    (method_line - 1).downto(0) do |index|
      line = lines[index].strip
      break if line.empty? || line.match?(/^def\s+/)

      if (match = line.match(/^#\s*@param\s+(?<name>\w+)\s+\[(?<type>\w+)\]\s+(?<description>.+)$/))
        params << { name: match[:name], type: match[:type], description: match[:description] }
      end
    end

    params.empty? ? nil : params
  end
end

class Method
  include MethodDescriptionExtractor
end

class UnboundMethod
  include MethodDescriptionExtractor
end
