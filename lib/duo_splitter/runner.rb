# frozen_string_literal: true

require 'optparse'

module DuoSplitter
  class Runner
    class << self
      def known_commands
        @known_commands ||= {}
      end

      def register_command(command_name, command_class)
        known_commands[command_name.to_sym] = command_class
      end
    end

    def initialize(argv)
      @argv = argv.dup
      @parser = OptionParser.new

      parse_options
    end

    def run
      command_name = @argv.shift

      if command_name
        command_class = self.class.known_commands[command_name.to_sym]

        raise Error, "unknown command: #{command_name}" unless command_class

        command_class.new(@argv).run
      else
        show_help
      end
    end

    private

    def parse_options
      @parser.banner = "Usage: #{@parser.program_name} [options] command"

      @parser.on('-h', '--help', 'Print this message') do
        show_help
        exit
      end

      @parser.on('-v', '--version', 'Print version number') do
        puts DuoSplitter::VERSION
        exit
      end

      begin
        @parser.order!(@argv)
      rescue OptionParser::ParseError => e
        raise Error, e.message
      end
    end

    def show_help
      puts @parser
      puts
      puts <<~MESSAGE
        Available commands are:

          - split
          - repeating
          - overlapping
      MESSAGE
    end
  end
end
