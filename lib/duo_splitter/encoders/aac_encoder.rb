# frozen_string_literal: true

module DuoSplitter
  module Encoders
    class AACEncoder < BaseEncoder
      def encoding_options
        %w[-codec:a aac -b:a 256k]
      end

      def ext
        'm4a'
      end

      BaseEncoder.register_encoder(:aac, self)
    end
  end
end
