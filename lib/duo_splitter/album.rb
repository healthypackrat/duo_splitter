module DuoSplitter
  class Album
    attr_reader :sections

    def initialize
      @sections = load_sections
    end

    def sentences(intro: true)
      sections.map(&:sentences).flatten.reject do |sentence|
        !intro && sentence.intro?
      end
    end

    private

    def load_sections
      1.upto(NUMBER_OF_SECTIONS).map {|n| Section.new(number: n) }
    end
  end
end
