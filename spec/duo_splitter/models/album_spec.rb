# frozen_string_literal: true

RSpec.describe DuoSplitter::Models::Album do
  let(:album) { described_class.new }

  it 'has 45 sections' do
    expect(album.sections.size).to eq(45)
  end

  describe '#sentences' do
    context 'when "intro" is true' do
      it 'returns 560 + 45 sentences' do
        expect(album.sentences(intro: true).size).to eq(560 + 45)
      end
    end

    context 'when "intro" is false' do
      it 'returns 560 sentences' do
        expect(album.sentences(intro: false).size).to eq(560)
      end
    end
  end

  it "doesn't have duplicate or missing sentences" do
    sentence_counts = 1.upto(DuoSplitter::NUMBER_OF_SENTENCES).each_with_object({}) {|n, memo| memo[n] = 0 }
    intro_counts = 1.upto(DuoSplitter::NUMBER_OF_SECTIONS).each_with_object({}) {|n, memo| memo[n] = 0 }

    album.sections.each do |section|
      section.sentences.each do |sentence|
        if sentence.intro?
          intro_counts[section.number] += 1
        else
          sentence_counts[sentence.number] += 1
        end
      end
    end

    duplicate_sentences = sentence_counts.select {|_, v| v > 1 }
    missing_sentences = sentence_counts.select {|_, v| v == 0 }

    duplicate_intro = intro_counts.select {|_, v| v > 1 }
    missing_intro = intro_counts.select {|_, v| v == 0 }

    aggregate_failures 'duplicate or missing' do
      expect(duplicate_sentences).to be_empty
      expect(missing_sentences).to be_empty

      expect(duplicate_intro).to be_empty
      expect(missing_intro).to be_empty
    end
  end
end
