# frozen_string_literal: true

RSpec.shared_context 'parsing concatenating options' do
  describe 'parsing concatenating options' do
    let(:context) { command.context }

    context 'when --sox-path was given with "/usr/local/bin/sox"' do
      let(:command) { described_class.new(%w[--sox-path=/usr/local/bin/sox] + argv) }

      specify 'context.sox_path is set to "/usr/local/bin/sox"' do
        expect(context.sox_path).to eq('/usr/local/bin/sox')
      end
    end

    context 'when --notification-sound-path was given with "/path/to/audio.wav"' do
      let(:command) { described_class.new(%w[--notification-sound-path=/path/to/audio.wav] + argv) }

      specify 'context.notification_sound_path is set to "/path/to/audio.wav"' do
        expect(context.notification_sound_path.to_s).to eq('/path/to/audio.wav')
      end
    end
  end
end
