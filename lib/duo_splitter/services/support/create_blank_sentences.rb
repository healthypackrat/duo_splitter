# frozen_string_literal: true

module DuoSplitter
  module Services
    module Support
      class CreateBlankSentences
        attr_reader :commands

        def initialize(context:)
          @context = context
          @commands = build_commands
        end

        def run
          return if @commands.empty?

          BatchProcessor.new(message: 'creating blank sentences...', show_progress: @context.show_progress).run(@commands)
        end

        private

        def build_commands
          sentences = @context.album.sentences(intro: @context.output_intro).select(&:audio_path)

          sentences.map do |sentence|
            output_path = @context.temp_dir.join(sentence.output_basename(prefix_section_number: @context.prefix_section_number, blank: true, ext: 'wav'))

            sentence.blank_audio_path = output_path

            command = [@context.sox_path]
            command += %w[-n -c 2 -e signed-integer -r 44100 -b 16]
            command += [output_path.to_s, 'trim', '0.0', sentence.duration.to_s]

            command
          end
        end
      end
    end
  end
end
