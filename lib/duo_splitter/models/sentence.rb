# frozen_string_literal: true

module DuoSplitter
  module Models
    class Sentence
      attr_reader :number, :start_pos, :end_pos, :section

      attr_accessor :audio_path, :blank_audio_path, :source_audio_path

      def initialize(number:, start_pos:, end_pos:, section:)
        @number = number
        @start_pos = start_pos
        @end_pos = end_pos
        @section = section
      end

      def duration
        Float(@end_pos) - Float(@start_pos)
      end

      def intro?
        number.zero?
      end

      def output_basename(ext:, prefix_section_number: true, blank: false, concatenated: false)
        basename = format('%03<number>d', number: number)
        basename = "#{basename}_blank" if blank
        basename = "#{basename}_concatenated" if concatenated
        basename = "#{basename}.#{ext}"
        basename = format('%02<section_number>d-', section_number: @section.number) + basename if prefix_section_number
        basename
      end
    end
  end
end
