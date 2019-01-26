require 'pathname'

module DuoSplitter
  class Encoder
    class << self
      def known_encoders
        @known_encoders ||= {}
      end

      def register(key, encoder)
        known_encoders[key] = encoder
      end
    end

    def initialize(album:, output_dir:, output_intro:, add_section_prefix:, ffmpeg_path:)
      @album = album
      @output_dir = Pathname.new(output_dir)
      @output_intro = output_intro
      @add_section_prefix = add_section_prefix
      @ffmpeg_path = ffmpeg_path
    end

    def run
      commands = to_commands

      @output_dir.mkpath

      commands.each do |command|
        unless system(*command)
          raise Error, "process exit with #{$?.exitstatus}"
        end
      end

      puts "\u{1F37A} done."
    end

    def to_commands
      sentences = @album.sentences(intro: @output_intro).select {|sentence| sentence.section.source_path }

      sentences.map do |sentence|
        output_name = sentence.output_name(add_section_prefix: @add_section_prefix, ext: ext)

        command = [@ffmpeg_path, '-y']
        command += ['-i', sentence.section.source_path.to_s]
        command += ['-ss', sentence.start_pos, '-to', sentence.end_pos]
        command += encoding_options
        command += [@output_dir.join(output_name).to_s]
        command
      end
    end

    def ext
      raise NotImplementedError, '#ext must be defined in a sub class'
    end

    def encoding_options
      raise NotImplementedError, '#encoding_options must be defined in a sub class'
    end
  end
end
