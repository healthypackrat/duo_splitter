# frozen_string_literal: true

require 'English'

module DuoSplitter
  class BatchProcessor
    def initialize(message:, show_progress: true)
      @message = message
      @show_progress = show_progress
    end

    def run(commands)
      commands.each.with_index(1) do |command, index|
        print_progress "#{@message} #{index}/#{commands.size}\r"

        shell_output = IO.popen(command, err: %i[child out], &:read)

        status = $CHILD_STATUS.exitstatus

        unless status.zero?
          print_progress "\n"
          print_progress "#{shell_output}\n"
          raise Error, "process exit with #{status}"
        end
      end

      print_progress "\n"
    end

    private

    def print_progress(str)
      $stderr.print(str) if @show_progress
    end
  end
end
