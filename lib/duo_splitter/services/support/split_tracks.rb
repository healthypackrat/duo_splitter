# frozen_string_literal: true

module DuoSplitter
  module Services
    module Support
      class SplitTracks
        attr_reader :commands

        def initialize(context:)
          @context = context
          @commands = build_commands
        end

        def run
          return if @commands.empty?

          BatchProcessor.new(message: 'splitting...', show_progress: @context.show_progress).run(@commands)
        end

        private

        def build_commands
          sentences = @context.album.sentences(intro: @context.output_intro).select {|sentence| sentence.section.audio_path }

          sentences.map do |sentence|
            output_path = @context.temp_dir.join(sentence.output_basename(prefix_section_number: @context.prefix_section_number, ext: 'wav'))

            sentence.source_audio_path = sentence.audio_path = output_path

            command = [@context.ffmpeg_path, '-y']
            command += ['-i', sentence.section.audio_path.to_s]
            command += ['-ss', sentence.start_pos, '-to', sentence.end_pos]
            command += %w[-codec:a pcm_s16le -ar 44100 -ac 2]
            command += [output_path.to_s]

            command
          end
        end
      end
    end
  end
end
