# frozen_string_literal: true

RSpec.describe DuoSplitter::Models::Section do
  let(:section) { described_class.new(number: 1) }

  it 'has a number' do
    expect(section.number).to eq(1)
  end

  describe '#sentences' do
    context 'when "intro" is true' do
      it 'returns 10 sentences' do
        expect(section.sentences(intro: true).size).to eq(10)
      end
    end

    context 'when "intro" is false' do
      it 'returns 9 sentences' do
        expect(section.sentences(intro: false).size).to eq(9)
      end
    end
  end
end
