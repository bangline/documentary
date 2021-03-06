module Documentary
  class Parser
    require 'yaml'

    def initialize(path)
      @path = path
      @docblocks = []
      @line_number = 0
      begin
        parse_file
      rescue Psych::SyntaxError
        raise Documentary::InvalidDocblock.new form_exception_message
      end
    end

    attr_reader :docblocks

    private

      attr_reader :path

      def parse_file
        File.open(path, 'r') do |file_content|
          in_docblock = false
          block_body = ""
          comment_delimeter = ""
          file_content.readlines.each do |line|
            line.rstrip!
            @line_number += 1
            if in_docblock && line.match(/---( |)end/)
              in_docblock = false
              yml = YAML.load(block_body)
              self.docblocks << Docblock.new(yml)
              block_body = ""
            end

            if line.match(/---( |)documentary/)
              comment_delimeter = line.match(/(.+)---/)[1]
              @current_docblock_start = @line_number
              in_docblock = true
            end

            if in_docblock
              if line.match(/---( |)documentary/)
                block_body << "---\n"
              elsif line == comment_delimeter.rstrip
                block_body << "\n"
              else
                regex = /^#{comment_delimeter}/
                block_body << "#{line.gsub(regex, '')}\n"
              end
            end
          end
        end
      end

      def form_exception_message
        "Invalid docblock YAML in file #{path}:#{@current_docblock_start}"
      end
  end
end
