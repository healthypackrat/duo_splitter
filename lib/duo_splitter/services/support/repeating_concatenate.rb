# frozen_string_literal: true

module DuoSplitter
  module Services
    module Support
      class RepeatingConcatenate < BaseConcatenate
        private

        def sentences
          context.album.sentences(intro: context.output_intro).select {|sentence| sentence.audio_path && sentence.blank_audio_path }
        end

        def source_paths(sentence)
          paths = [sentence.audio_path.to_s]
          paths += [context.notification_sound_path.to_s] if context.use_notification_sound
          paths += [sentence.blank_audio_path.to_s]
          paths
        end
      end
    end
  end
end
