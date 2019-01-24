require "duo_splitter/section"
require "duo_splitter/sentence"
require "duo_splitter/version"

module DuoSplitter
  class Error < StandardError; end

  DATA_DIR = Pathname.new(__dir__).parent.join('data')
end
