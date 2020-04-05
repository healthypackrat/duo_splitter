# frozen_string_literal: true

RSpec.describe DuoSplitter::Encoders::MP3Encoder do
  let(:context) { DuoSplitter::Context.new }
  let(:encoder) { described_class.new(context: context) }

  before do
    context.album.sentences.first.source_audio_path = '01-000.wav'
  end

  describe 'first command' do
    let(:command) { encoder.commands.first }

    it 'starts with "ffmpeg"' do
      expect(command).to start_with('ffmpeg')
    end

    it 'includes input path' do
      expect(command).to include('01-000.wav')
    end

    it 'ends with output path' do
      expect(command).to end_with(context.output_dir.join('01-000.mp3').to_s)
    end
  end
end
