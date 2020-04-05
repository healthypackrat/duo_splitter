# frozen_string_literal: true

module DuoSplitter
  module Encoders
    class BaseEncoder
      class << self
        def known_encoders
          @known_encoders ||= {}
        end

        def register_encoder(encoder_name, encoder_class)
          known_encoders[encoder_name.to_sym] = encoder_class
        end
      end

      attr_reader :commands

      def initialize(context:)
        @context = context
        @commands = build_commands
      end

      def run
        return if @commands.empty?

        @context.output_dir.mkpath

        BatchProcessor.new(message: 'encoding...', show_progress: @context.show_progress).run(@commands)
      end

      private

      def build_commands
        sentences = @context.album.sentences(intro: @context.output_intro).select(&:source_audio_path)

        sentences.map do |sentence|
          output_basename = sentence.output_basename(prefix_section_number: @context.prefix_section_number, ext: ext)

          command = [@context.ffmpeg_path, '-y']
          command += ['-i', sentence.source_audio_path.to_s]
          command += encoding_options
          command += [@context.output_dir.join(output_basename).to_s]

          command
        end
      end

      def encoding_options
        raise Error, '#encoding_options must be defined in sub classes'
      end

      def ext
        raise Error, '#ext must be defined in sub classes'
      end
    end
  end
end
