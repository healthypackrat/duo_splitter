# frozen_string_literal: true

module DuoSplitter
  module Services
    module Support
      class Encode
        def initialize(context:)
          @context = context
        end

        def run
          output_format = @context.output_format.to_sym

          encoder_class = Encoders::BaseEncoder.known_encoders[output_format]

          raise Error, "unknown output format: #{output_format}" unless encoder_class

          encoder_class.new(context: @context).run
        end
      end
    end
  end
end
