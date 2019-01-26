module DuoSplitter
  class Sentence
    attr_reader :number, :start_pos, :end_pos, :section

    def initialize(number:, start_pos:, end_pos:, section:)
      @number = number
      @start_pos = start_pos
      @end_pos = end_pos
      @section = section
    end

    def intro?
      number.zero?
    end

    def output_name(add_section_prefix: true, ext:)
      name = '%03d.%s' % [number, ext]
      name = ('%02d-' % section.number) + name if add_section_prefix
      name
    end
  end
end
