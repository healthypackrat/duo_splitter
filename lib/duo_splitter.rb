require "duo_splitter/album"
require "duo_splitter/section"
require "duo_splitter/sentence"
require "duo_splitter/version"

module DuoSplitter
  class Error < StandardError; end

  DATA_DIR = Pathname.new(__dir__).parent.join('data')

  NUMBER_OF_SECTIONS = 45

  NUMBER_OF_SENTENCES = 560
end
