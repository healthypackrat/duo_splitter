# frozen_string_literal: true

module DuoSplitter
  module Encoders
    class MP3Encoder < BaseEncoder
      def encoding_options
        %w[-codec:a libmp3lame -b:a 320k]
      end

      def ext
        'mp3'
      end

      BaseEncoder.register_encoder(:mp3, self)
    end
  end
end
