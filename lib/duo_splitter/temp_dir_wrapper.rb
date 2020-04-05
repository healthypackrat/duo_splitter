# frozen_string_literal: true

require 'pathname'
require 'tmpdir'

module DuoSplitter
  class TempDirWrapper
    def initialize(context:)
      @context = context
    end

    def run
      Dir.mktmpdir do |dirname|
        @context.temp_dir = Pathname.new(dirname)

        yield
      end
    end
  end
end
