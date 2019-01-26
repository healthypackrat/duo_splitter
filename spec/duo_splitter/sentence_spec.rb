RSpec.describe DuoSplitter::Sentence do
  let(:section) { DuoSplitter::Section.new(number: 1) }
  let(:sentence) { described_class.new(number: 1, start_pos: '1.23', end_pos: '4.56', section: section) }

  it "has a number" do
    expect(sentence.number).to eq(1)
  end

  it "has a start_pos" do
    expect(sentence.start_pos).to eq('1.23')
  end

  it "has an end_pos" do
    expect(sentence.end_pos).to eq('4.56')
  end

  describe "#intro?" do
    context "when number is 0" do
      let(:sentence) { described_class.new(number: 0, start_pos: '1.23', end_pos: '4.56', section: section) }

      it "returns true" do
        expect(sentence).to be_intro
      end
    end

    context "when number isn't 0" do
      let(:sentence) { described_class.new(number: 1, start_pos: '1.23', end_pos: '4.56', section: section) }

      it "returns false" do
        expect(sentence).not_to be_intro
      end
    end
  end

  describe "#output_name" do
    context "when add_section_prefix is true" do
      example { expect(sentence.output_name(add_section_prefix: true, ext: 'wav')).to eq('01-001.wav') }
    end

    context "when add_section_prefix is false" do
      example { expect(sentence.output_name(add_section_prefix: false, ext: 'wav')).to eq('001.wav') }
    end
  end
end
