# frozen_string_literal: true

module DuoSplitter
  module Encoders
    class WAVEncoder < BaseEncoder
      def encoding_options
        %w[-codec:a pcm_s16le -ar 44100 -ac 2]
      end

      def ext
        'wav'
      end

      BaseEncoder.register_encoder(:wav, self)
    end
  end
end
