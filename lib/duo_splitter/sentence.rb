module DuoSplitter
  class Sentence
    attr_reader :number, :start_pos, :end_pos

    def initialize(number:, start_pos:, end_pos:)
      @number = number
      @start_pos = start_pos
      @end_pos = end_pos
    end

    def intro?
      number.zero?
    end
  end
end
