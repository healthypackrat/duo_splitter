require "duo_splitter/album"
require "duo_splitter/section"
require "duo_splitter/sentence"

require "duo_splitter/encoder"
require "duo_splitter/wav_encoder"

require "duo_splitter/version"

require 'pathname'

module DuoSplitter
  class Error < StandardError; end

  DATA_DIR = Pathname.new(__dir__).parent.join('data')

  NUMBER_OF_SECTIONS = 45

  NUMBER_OF_SENTENCES = 560
end
