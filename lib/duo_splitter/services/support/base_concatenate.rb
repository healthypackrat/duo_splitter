# frozen_string_literal: true

module DuoSplitter
  module Services
    module Support
      class BaseConcatenate
        attr_reader :context, :commands

        def initialize(context:)
          @context = context

          raise Error, "temp_dir isn't set" unless @context.temp_dir

          @commands = build_commands
        end

        def run
          return if @commands.empty?

          BatchProcessor.new(message: 'concatenating...', show_progress: @context.show_progress).run(@commands)
        end

        private

        def build_commands
          sentences.map do |sentence|
            output_path = @context.temp_dir.join(sentence.output_basename(prefix_section_number: @context.prefix_section_number, concatenated: true, ext: 'wav'))

            sentence.source_audio_path = output_path

            command = [@context.sox_path]
            command += source_paths(sentence)
            command += [output_path.to_s]

            command
          end
        end

        def sentences
          raise Error, '#sentences must be defined in sub classes'
        end

        def source_paths(_sentence)
          raise Error, '#source_paths must be defined in sub classes'
        end
      end
    end
  end
end
