require 'optparse'
require 'documentary'

module Documentary
  class Cli
    def self.run(args, out=STDOUT)
      file_glob = "./**/*.rb"
      config = { project: "My Project" }

      OptionParser.new do |opts|
        opts.on("-v", "--version", "Print version number") do
          require "documentary/version"
          out << "Documentary #{Documentary::VERSION}\n"
          exit
        end

        opts.on("-d", "--directory glob", "Set directory path") do |glob|
          file_glob = file_glob = glob
        end

        opts.on("-p", "--project project", "Set directory path") do |project|
        end
      end.parse!

      files = Dir.glob(file_glob)
      Documentary::Generator.new(files, config).generate
    end
  end
end
