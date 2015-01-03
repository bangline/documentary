module Documentary
  require 'pry'
  require 'ostruct'
  require 'documentary/docblock'
  require 'documentary/docblock_collection'
  require 'documentary/parser'

  class InvalidDocblock < StandardError; end

  class Generator
    require 'erb'

    def self.build(file_tree)
      docblocks = DocblockCollection.new
      file_tree.each do |path|
        parsed_file = Parser.new(path)
        docblocks.concat parsed_file.docblocks
        template = File.expand_path('../default_layout.erb', __FILE__)
        erb = ERB.new(File.new(template).read, nil, '<>')
        File.open('api.md', 'w+') do |file|
          file.write erb.result(binding)
        end
      end
    end
  end
end
