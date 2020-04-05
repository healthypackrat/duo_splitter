# frozen_string_literal: true

require 'duo_splitter/models/album'
require 'duo_splitter/models/section'
require 'duo_splitter/models/sentence'

require 'duo_splitter/batch_processor'

require 'duo_splitter/context'

require 'duo_splitter/temp_dir_wrapper'

require 'duo_splitter/encoders/base_encoder'
require 'duo_splitter/encoders/aac_encoder'
require 'duo_splitter/encoders/mp3_encoder'
require 'duo_splitter/encoders/wav_encoder'

require 'duo_splitter/services/support/base_concatenate'
require 'duo_splitter/services/support/repeating_concatenate'
require 'duo_splitter/services/support/overlapping_concatenate'

require 'duo_splitter/services/support/create_blank_sentences'
require 'duo_splitter/services/support/encode'
require 'duo_splitter/services/support/split_tracks'

require 'duo_splitter/services/create_sentences'
require 'duo_splitter/services/create_repeating_sentences'
require 'duo_splitter/services/create_overlapping_sentences'

require 'duo_splitter/runner'

require 'duo_splitter/commands/base_command'
require 'duo_splitter/commands/split_command'
require 'duo_splitter/commands/repeating_command'
require 'duo_splitter/commands/overlapping_command'

require 'duo_splitter/version'

require 'pathname'

module DuoSplitter
  class Error < StandardError; end

  ROOT_DIR = Pathname.new(__dir__).parent

  ASSETS_DIR = ROOT_DIR.join('assets')

  DATA_DIR = ROOT_DIR.join('data')

  NUMBER_OF_SECTIONS = 45

  NUMBER_OF_SENTENCES = 560
end
