RSpec.describe DuoSplitter::WAVEncoder do
  let(:album) { DuoSplitter::Album.new }
  let(:output_dir) { File.expand_path('~/Desktop/DUO 3.0') }
  let(:ffmpeg_path) { 'ffmpeg' }
  let(:source_path) { '01 Track 01.wav' }

  describe "#to_commands" do
    describe "for section #1" do
      before do
        section = album.sections.first
        section.source_path = source_path
      end

      context "when output_intro is true" do
        let(:encoder) { described_class.new(output_intro: true, add_section_prefix: true, album: album, output_dir: output_dir, ffmpeg_path: ffmpeg_path) }
        let(:commands) { encoder.to_commands }
        let(:first_command) { commands.first }

        it "generates 10 commands" do
          expect(commands.size).to eq(10)
        end

        it "generates an intro command" do
          expect(first_command).to eq(['ffmpeg', '-y', '-i', '01 Track 01.wav', '-ss', '0', '-to', '2.960000', '-codec:a', 'pcm_s16le', File.expand_path('~/Desktop/DUO 3.0/01-000.wav')])
        end
      end

      context "when output_intro is false" do
        let(:encoder) { described_class.new(output_intro: false, add_section_prefix: false, album: album, output_dir: output_dir, ffmpeg_path: ffmpeg_path) }
        let(:commands) { encoder.to_commands }
        let(:first_command) { commands.first }

        it "generates 9 commands" do
          expect(commands.size).to eq(9)
        end

        it "doesn't generate an intro command" do
          expect(first_command).to eq(['ffmpeg', '-y', '-i', '01 Track 01.wav', '-ss', '2.960000', '-to', '6.930000', '-codec:a', 'pcm_s16le', File.expand_path('~/Desktop/DUO 3.0/001.wav')])
        end
      end
    end
  end
end
