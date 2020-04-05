# frozen_string_literal: true

require 'optparse'
require 'pathname'

module DuoSplitter
  module Commands
    class BaseCommand
      attr_reader :parser, :context

      def initialize(argv)
        @parser = OptionParser.new
        @context = Context.new
        @context.output_dir = default_output_dir if default_output_dir

        parse_options(argv)
        handle_audio_paths(argv)
      end

      def run
        raise Error, '#run must be defined in sub classes'
      end

      private

      def default_output_dir
        nil
      end

      def print_done
        puts 'done.' if context.show_progress
      end

      def on_output_dir
        parser.on('-d', '--output-dir=PATH', "Output directory (default: #{context.output_dir.to_s.inspect})") do |path|
          context.output_dir = Pathname.new(path)
        end
      end

      def on_output_format
        formats = Encoders::BaseEncoder.known_encoders.keys.sort.map(&:to_s)
        message = %(Output format (default: #{context.output_format.inspect}; one of #{formats.map(&:inspect).join(', ')}))
        parser.on('-f', '--format=FORMAT', formats, message) do |format|
          context.output_format = format
        end
      end

      def on_output_intro
        parser.on('--[no-]output-intro', "Output intro track (default: #{context.output_intro})") do |flag|
          context.output_intro = flag
        end
      end

      def on_prefix_section_number
        parser.on('--[no-]section-number', "Add section number to output file name (default: #{context.prefix_section_number})") do |flag|
          context.prefix_section_number = flag
        end
      end

      def on_show_progress
        parser.on('--[no-]progress', "Show progress (default: #{context.show_progress})") do |flag|
          context.show_progress = flag
        end
      end

      def on_ffmpeg_path
        parser.on('--ffmpeg-path=PATH', "Path to ffmpeg command (default: #{context.ffmpeg_path.inspect})") do |path|
          context.ffmpeg_path = path
        end
      end

      def on_sox_path
        parser.on('--sox-path=PATH', "Path to sox command (default: #{context.sox_path.inspect})") do |path|
          context.sox_path = path
        end
      end

      def on_use_notification_sound
        parser.on('--[no-]notification-sound', "Use notification sound (default: #{context.use_notification_sound})") do |flag|
          context.use_notification_sound = flag
        end
      end

      def on_notification_sound_path
        parser.on('--notification-sound-path=PATH', "Path to notification sound (default: #{context.notification_sound_path})") do |path|
          context.notification_sound_path = Pathname.new(path)
        end
      end

      def parse!(argv)
        parser.order!(argv)
      rescue OptionParser::ParseError => e
        raise Error, e.message
      end

      def after_parse
        context.output_intro = false unless context.prefix_section_number
      end

      def handle_audio_paths(argv)
        raise Error, 'no input files were given' if argv.empty?

        argv.each do |filename|
          audio_path = Pathname.new(filename)

          match_data = /\A(\d+)/.match(audio_path.basename.to_s)

          raise Error, "input file name doesn't start with a number: #{audio_path.basename}" unless match_data

          section_number = match_data[1].to_i

          section = context.album.sections.find {|s| s.number == section_number }

          raise Error, "invalid section number: #{section_number}" unless section

          section.audio_path = audio_path
        end
      end
    end
  end
end
