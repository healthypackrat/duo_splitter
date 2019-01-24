RSpec.describe DuoSplitter::Section do
  describe "section #1" do
    let(:section) { described_class.new(number: 1) }

    it "has 10 sentences" do
      expect(section.sentences.size).to eq(10)
    end
  end
end
