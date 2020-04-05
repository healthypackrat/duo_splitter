# frozen_string_literal: true

module DuoSplitter
  module Services
    module Support
      class OverlappingConcatenate < BaseConcatenate
        private

        def sentences
          context.album.sentences(intro: context.output_intro).select(&:audio_path)
        end

        def source_paths(sentence)
          [context.notification_sound_path.to_s, sentence.audio_path.to_s]
        end
      end
    end
  end
end
