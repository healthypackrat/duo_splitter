# frozen_string_literal: true

RSpec.describe DuoSplitter::Services::Support::CreateBlankSentences do
  let(:context) { DuoSplitter::Context.new }
  let(:service) { described_class.new(context: context) }

  context 'when context.temp_dir is set' do
    before do
      context.album.sentences.first.audio_path = '01-000.wav'
      context.temp_dir = Pathname.new('tmp')
    end

    describe 'first command' do
      let(:command) { service.commands.first }

      it 'starts with "sox"' do
        expect(command).to start_with('sox')
      end

      it 'includes output path' do
        expect(command).to include('tmp/01-000_blank.wav')
      end
    end
  end

  context "when context.temp_dir isn't set" do
    it 'raises an error' do
      expect { service }.to raise_error(DuoSplitter::Error, "temp_dir isn't set")
    end
  end
end
