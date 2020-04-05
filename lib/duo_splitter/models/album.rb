# frozen_string_literal: true

module DuoSplitter
  module Models
    class Album
      attr_reader :sections

      def initialize
        @sections = load_sections
      end

      def sentences(intro: true)
        sections.map {|section| section.sentences(intro: intro) }.flatten
      end

      private

      def load_sections
        1.upto(NUMBER_OF_SECTIONS).map {|n| Section.new(number: n) }
      end
    end
  end
end
