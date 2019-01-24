RSpec.describe DuoSplitter::Sentence do
  let(:sentence) { described_class.new(number: 1, start_pos: '1.23', end_pos: '4.56') }

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
      let(:sentence) { described_class.new(number: 0, start_pos: '1.23', end_pos: '4.56') }

      it "returns true" do
        expect(sentence).to be_intro
      end
    end

    context "when number isn't 0" do
      let(:sentence) { described_class.new(number: 1, start_pos: '1.23', end_pos: '4.56') }

      it "returns false" do
        expect(sentence).not_to be_intro
      end
    end
  end
end
