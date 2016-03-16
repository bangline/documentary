require 'optparse'
require 'documentary'

module Documentary
  class Cli
    def self.run(args, out=STDOUT)
      OptionParser.new do |opts|
        opts.on_tail("-v", "--version", "Print version number") do
          require "documentary/version"
          out << "Documentary #{Documentary::VERSION}\n"
          exit
        end
      end.parse!
    end
  end
end
