class Method
  def description
    @description ||= begin
      path, line_number = source_location

      return nil unless path && File.file?(path)

      file = File.read(path)

      if file =~ Regexp.new(%Q{\\A(?:.*?\n){#{line_number}}\s*?"""([\\s\\S]+?)"""})
        $1.gsub(/\n\s+/, "\n").strip
      else
        nil
      end

    end
  end
end
