RSpec.describe DuoSplitter::Encoder do
  let(:album) { DuoSplitter::Album.new }
  let(:output_dir) { File.expand_path('~/Desktop/DUO 3.0') }
  let(:ffmpeg_path) { 'ffmpeg' }
  let(:source_path) { '01 Track 01.wav' }
  let(:encoder) { described_class.new(output_intro: true, add_section_prefix: true, album: album, output_dir: output_dir, ffmpeg_path: ffmpeg_path) }

  before do
    section = album.sections.first
    section.source_path = source_path
  end

  it "raises a NotImplementedError" do
    expect { encoder.to_commands }.to raise_error(NotImplementedError)
  end
end
