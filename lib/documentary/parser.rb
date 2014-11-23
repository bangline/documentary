module Documentary
  class Parser
    require 'yaml'

    def initialize(path)
      @path = path
      @docblocks = []
      parse_file
    end

    attr_reader :docblocks

    private

      attr_reader :path

      def parse_file
        File.open(path, 'r') do |file_content|
          in_docblock = false
          block_body = ""
          file_content.readlines.each do |line|
            if in_docblock && line.match(/---( |)end/)
              in_docblock = false
              yml = YAML.load(block_body)
              self.docblocks << Docblock.new(yml)
              block_body = ""
            end

            if line.match(/---( |)documentary/)
              in_docblock = true
            end

            if in_docblock
              if  line.match(/---( |)documentary/)
                block_body << "---\n"
              else
                block_body << "#{line.strip.gsub(/^# /, '')}\n"
              end
            end
          end
        end
      end
  end

  class Docblock < OpenStruct
    def initialize(hsh)
      super(hsh)
      self.type = self.type.to_sym
    end
  end
end