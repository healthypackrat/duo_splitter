RSpec.describe DuoSplitter::Encoder do
  let(:album) { DuoSplitter::Album.new }
  let(:output_dir) { File.expand_path('~/Desktop/DUO 3.0') }
  let(:ffmpeg_path) { 'ffmpeg' }
  let(:source_path) { '01 Track 01.wav' }
  let(:encoder) { described_class.new(output_intro: true, add_section_prefix: true, album: album, output_dir: output_dir, ffmpeg_path: ffmpeg_path) }

  describe "#to_commands" do
    before do
      section = album.sections.first
      section.source_path = source_path
    end

    it "raises a NotImplementedError" do
      expect { encoder.to_commands }.to raise_error(DuoSplitter::Error)
    end
  end

  describe ".known_encoders" do
    it "returns known encoders" do
      expect(DuoSplitter::Encoder.known_encoders).to eq({ mp3: DuoSplitter::MP3Encoder, wav: DuoSplitter::WAVEncoder, aac: DuoSplitter::AACEncoder })
    end
  end
end
