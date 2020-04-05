# frozen_string_literal: true

module DuoSplitter
  module Commands
    class SplitCommand < BaseCommand
      def run
        Services::CreateSentences.new(context: context).run
        print_done
      end

      private

      def parse_options(argv)
        parser.banner = %(Usage: #{parser.program_name} [options] split "01 Track 01.wav" ... "45 Track 45.wav")

        on_output_dir
        on_output_format
        on_output_intro
        on_prefix_section_number
        on_show_progress
        on_ffmpeg_path

        parse!(argv)

        after_parse
      end

      Runner.register_command(:split, self)
    end
  end
end
