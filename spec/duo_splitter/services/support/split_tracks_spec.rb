# frozen_string_literal: true

require 'pathname'

RSpec.describe DuoSplitter::Services::Support::SplitTracks do
  let(:context) { DuoSplitter::Context.new }
  let(:service) { described_class.new(context: context) }

  context 'when context.temp_dir is set' do
    before do
      context.album.sections.first.audio_path = '01 Track 01.wav'
      context.temp_dir = Pathname.new('tmp')
    end

    describe 'first command' do
      let(:command) { service.commands.first }

      it 'starts with "ffmpeg"' do
        expect(command).to start_with('ffmpeg')
      end

      it 'includes input path' do
        expect(command).to include('01 Track 01.wav')
      end

      it 'ends with output path' do
        expect(command).to end_with('tmp/01-000.wav')
      end
    end
  end

  context "when context.temp_dir isn't set" do
    it 'raises an error' do
      expect { service }.to raise_error(DuoSplitter::Error, "temp_dir isn't set")
    end
  end
end
