# frozen_string_literal: true

module DuoSplitter
  module Models
    class Section
      attr_reader :number

      attr_accessor :audio_path

      def initialize(number:)
        @number = number
        @sentences = load_sentences
      end

      def sentences(intro: true)
        @sentences.reject {|sentence| !intro && sentence.intro? }
      end

      private

      def load_sentences
        label_path = DATA_DIR.join(format('labels/%02<number>d.txt', number: number))

        records = label_path.readlines.map {|line| line.chomp.split(/\t/) }

        records.unshift(%w[0 0 0])

        records.each_cons(2).map do |current_record, next_record|
          sentence_number = current_record.last.to_i
          start_pos = current_record.first
          end_pos = next_record.first

          Sentence.new(number: sentence_number, start_pos: start_pos, end_pos: end_pos, section: self)
        end
      end
    end
  end
end
