# frozen_string_literal: true

RSpec.shared_context 'parsing common options' do
  describe 'parsing common options' do
    let(:context) { command.context }

    context 'when --output-dir option was given with "output"' do
      let(:command) { described_class.new(%w[--output-dir=output] + argv) }

      specify 'context.output_dir is set to "output"' do
        expect(context.output_dir.to_s).to eq('output')
      end
    end

    context 'when --format was given with "mp3"' do
      let(:command) { described_class.new(%w[--format=mp3] + argv) }

      specify 'context.output_format is set to "mp3"' do
        expect(context.output_format).to eq('mp3')
      end
    end

    context 'when --no-output-intro was given' do
      let(:command) { described_class.new(%w[--no-output-intro] + argv) }

      specify 'context.output_intro is set to false' do
        expect(context.output_intro).to eq(false)
      end
    end

    context 'when --no-section-number was given' do
      let(:command) { described_class.new(%w[--no-section-number] + argv) }

      specify 'context.prefix_section_number is set to false' do
        expect(context.prefix_section_number).to eq(false)
      end

      specify 'context.output_intro is set to false' do
        expect(context.output_intro).to eq(false)
      end
    end

    context 'when --no-progress option was given' do
      let(:command) { described_class.new(%w[--no-progress] + argv) }

      specify 'context.show_progress is set to false' do
        expect(context.show_progress).to eq(false)
      end
    end

    context 'when --ffmpeg-path was given with "/usr/local/bin/ffmpeg"' do
      let(:command) { described_class.new(%w[--ffmpeg-path=/usr/local/bin/ffmpeg] + argv) }

      specify 'context.ffmpeg_path is set to "/usr/local/bin/ffmpeg"' do
        expect(context.ffmpeg_path).to eq('/usr/local/bin/ffmpeg')
      end
    end
  end
end
