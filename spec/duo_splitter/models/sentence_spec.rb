# frozen_string_literal: true

RSpec.describe DuoSplitter::Models::Sentence do
  let(:section) { double('section', number: 1) }
  let(:args) { { number: 1, start_pos: '3.0', end_pos: '5.0', section: section } }
  let(:sentence) { described_class.new(**args) }

  it 'has a number' do
    expect(sentence.number).to eq(1)
  end

  it 'has a start_pos' do
    expect(sentence.start_pos).to eq('3.0')
  end

  it 'has an end_pos' do
    expect(sentence.end_pos).to eq('5.0')
  end

  it 'calculates its duration' do
    expect(sentence.duration).to eq(2.0)
  end

  describe '#intro?' do
    context 'when number is 0' do
      let(:sentence) { described_class.new(**args.merge(number: 0)) }

      it 'is intro' do
        expect(sentence).to be_intro
      end
    end

    context "when number isn't 0" do
      let(:sentence) { described_class.new(**args.merge(number: 1)) }

      it "isn't intro" do
        expect(sentence).not_to be_intro
      end
    end
  end

  describe '#output_basename' do
    context 'when "prefix_section_number" is true' do
      it 'prefixes a section number' do
        expect(sentence.output_basename(prefix_section_number: true, ext: 'wav')).to eq('01-001.wav')
      end
    end

    context 'when "prefix_section_number" is false' do
      it "doesn't prefix a section number" do
        expect(sentence.output_basename(prefix_section_number: false, ext: 'wav')).to eq('001.wav')
      end
    end

    context 'when "blank" is true' do
      it 'postfixes "_blank"' do
        expect(sentence.output_basename(blank: true, ext: 'wav')).to eq('01-001_blank.wav')
      end
    end

    context 'when "blank" is false' do
      it %(doesn't postfix "_blank") do
        expect(sentence.output_basename(blank: false, ext: 'wav')).to eq('01-001.wav')
      end
    end

    context 'when "concatenated" is true' do
      it 'postfixes "_concatenated"' do
        expect(sentence.output_basename(concatenated: true, ext: 'wav')).to eq('01-001_concatenated.wav')
      end
    end

    context 'when "concatenated" is false' do
      it %(doesn't postfix "_concatenated") do
        expect(sentence.output_basename(concatenated: false, ext: 'wav')).to eq('01-001.wav')
      end
    end
  end
end
