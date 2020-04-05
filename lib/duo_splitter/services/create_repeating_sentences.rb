# frozen_string_literal: true

module DuoSplitter
  module Services
    class CreateRepeatingSentences
      def initialize(context:)
        @context = context
      end

      def run
        TempDirWrapper.new(context: @context).run do
          Support::SplitTracks.new(context: @context).run
          Support::CreateBlankSentences.new(context: @context).run
          Support::RepeatingConcatenate.new(context: @context).run
          Support::Encode.new(context: @context).run
        end
      end
    end
  end
end
