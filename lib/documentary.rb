module Documentary
  require 'ostruct'
  require 'documentary/version'
  require 'documentary/docblock'
  require 'documentary/docblock_collection'
  require 'documentary/parser'
  require 'documentary/view/helpers'

  class InvalidDocblock < StandardError; end

  class Generator
    require 'erb'
    require 'json'
    require 'active_support/inflector'

    include View

    def initialize(file_tree, config={})
      @docblocks = DocblockCollection.new
      @file_tree = file_tree
      @config = config
    end

    def generate
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

    private

      attr_reader :file_tree, :config
      attr_accessor :docblocks

      def project_name
        config[:project]
      end
  end
end
