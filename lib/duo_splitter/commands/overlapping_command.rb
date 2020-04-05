# frozen_string_literal: true

module DuoSplitter
  module Commands
    class OverlappingCommand < BaseCommand
      def run
        Services::CreateOverlappingSentences.new(context: context).run
        print_done
      end

      private

      def default_output_dir
        Pathname.new('~/Desktop/DUO 3.0 (Overlapping)').expand_path
      end

      def parse_options(argv)
        parser.banner = %(Usage: #{parser.program_name} [options] overlapping "01 Track 01.wav" ... "45 Track 45.wav")

        on_output_dir
        on_output_format
        on_output_intro
        on_prefix_section_number
        on_show_progress
        on_ffmpeg_path
        on_sox_path
        on_notification_sound_path

        parse!(argv)

        after_parse
      end

      Runner.register_command(:overlapping, self)
    end
  end
end
