# frozen_string_literal: true

RSpec.describe DuoSplitter::Services::Support::RepeatingConcatenate do
  let(:context) { DuoSplitter::Context.new }
  let(:service) { described_class.new(context: context) }

  before do
    context.temp_dir = Pathname.new('tmp')
    context.album.sentences.first.audio_path = context.temp_dir.join('01-000.wav')
    context.album.sentences.first.blank_audio_path = context.temp_dir.join('01-000_blank.wav')
  end

  describe 'first command' do
    let(:command) { service.commands.first }

    context 'when context.use_notification_sound is true' do
      before do
        context.use_notification_sound = true
      end

      it 'starts with "sox"' do
        expect(command).to start_with('sox')
      end

      it 'includes original sentence path' do
        expect(command).to include('tmp/01-000.wav')
      end

      it 'includes notification sound path' do
        expect(command).to include(context.notification_sound_path.to_s)
      end

      it 'includes blank sentence path' do
        expect(command).to include('tmp/01-000_blank.wav')
      end

      it 'ends with output path' do
        expect(command).to end_with('tmp/01-000_concatenated.wav')
      end
    end

    context 'when context.use_notification_sound is false' do
      before do
        context.use_notification_sound = false
      end

      it 'starts with "sox"' do
        expect(command).to start_with('sox')
      end

      it 'includes original sentence path' do
        expect(command).to include('tmp/01-000.wav')
      end

      it 'includes notification sound path' do
        expect(command).not_to include(context.notification_sound_path.to_s)
      end

      it 'includes blank sentence path' do
        expect(command).to include('tmp/01-000_blank.wav')
      end

      it 'ends with output path' do
        expect(command).to end_with('tmp/01-000_concatenated.wav')
      end
    end
  end
end
