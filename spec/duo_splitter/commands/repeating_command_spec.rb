# frozen_string_literal: true

RSpec.describe DuoSplitter::Commands::RepeatingCommand do
  let(:argv) { ['01 Track 01.wav'] }
  let(:command) { described_class.new(argv) }

  include_context 'parsing common options'
  include_context 'parsing concatenating options'
  include_context 'handling input files'

  describe 'parsing extra options' do
    let(:context) { command.context }

    context 'when --no-notification-sound option was given' do
      let(:command) { described_class.new(%w[--no-notification-sound] + argv) }

      specify 'context.use_notification_sound is set to false' do
        expect(context.use_notification_sound).to eq(false)
      end
    end
  end

  it 'outputs to "~/Desktop/DUO 3.0 (Repeating)" by default' do
    expect(command.context.output_dir.to_s).to eq(File.expand_path('~/Desktop/DUO 3.0 (Repeating)'))
  end
end
