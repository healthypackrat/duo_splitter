# frozen_string_literal: true

RSpec.describe DuoSplitter::Services::Support::OverlappingConcatenate do
  let(:context) { DuoSplitter::Context.new }
  let(:service) { described_class.new(context: context) }

  context 'when context.temp_dir is set' do
    before do
      context.temp_dir = Pathname.new('tmp')
      context.album.sentences.first.audio_path = context.temp_dir.join('01-000.wav')
    end

    describe 'first command' do
      let(:command) { service.commands.first }

      it 'starts with "sox"' do
        expect(command).to start_with('sox')
      end

      it 'includes notification sound path' do
        expect(command).to include(context.notification_sound_path.to_s)
      end

      it 'includes original sentence path' do
        expect(command).to include('tmp/01-000.wav')
      end

      it 'ends with output path' do
        expect(command).to end_with('tmp/01-000_concatenated.wav')
      end
    end
  end

  context "when context.temp_dir isn't set" do
    it 'raises an error' do
      expect { service }.to raise_error(DuoSplitter::Error, "temp_dir isn't set")
    end
  end
end
