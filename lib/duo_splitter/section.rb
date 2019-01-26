module DuoSplitter
  class Section
    attr_reader :number, :sentences

    attr_accessor :source_path

    def initialize(number:)
      @number = number
      @sentences = load_sentences
    end

    private

    def load_sentences
      label_path = DATA_DIR.join('labels/%02d.txt' % number)

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
