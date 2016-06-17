require 'optparse'
require 'documentary'

module Documentary
  class Cli
    def self.run(args, out=STDOUT)
      file_glob = "./**/*.rb"
      project_name = File.basename(Dir.getwd).split.each {|w| w.capitalize! }.join(' ')
      output = 'api.md'

      OptionParser.new do |opts|
        opts.on("-v", "--version", "Print version number") do
          require "documentary/version"
          out << "Documentary #{Documentary::VERSION}\n"
          exit
        end

        opts.on("-d", "--directory glob", "Set directory to search for docblocks") do |glob|
          file_glob = glob
        end

        opts.on("-p", "--project project", "Set project name") do |project|
          project_name = project
        end

        opts.on("-o", "--output output", "Set the output file") do |op|
          output = op
        end
      end.parse!

      files = Dir.glob(file_glob)
      config = {
        project: project_name,
        op: output
      }
      Documentary::Generator.new(files, config).generate
    end
  end
end
