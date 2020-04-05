# frozen_string_literal: true

require 'pathname'

module DuoSplitter
  class Context
    attr_reader :album

    attr_accessor :output_dir
    attr_accessor :output_format
    attr_accessor :output_intro
    attr_accessor :prefix_section_number
    attr_accessor :show_progress
    attr_accessor :ffmpeg_path
    attr_accessor :sox_path
    attr_accessor :use_notification_sound
    attr_accessor :notification_sound_path
    attr_accessor :temp_dir

    def initialize
      @album = Models::Album.new
      @output_dir = Pathname.new('~/Desktop/DUO 3.0').expand_path
      @output_format = 'wav'
      @output_intro = true
      @prefix_section_number = true
      @show_progress = true
      @ffmpeg_path = 'ffmpeg'
      @sox_path = 'sox'
      @use_notification_sound = true
      @notification_sound_path = ASSETS_DIR.join('C4.wav')
      @temp_dir = nil
    end
  end
end
