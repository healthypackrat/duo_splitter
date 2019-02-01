RSpec.describe DuoSplitter::MP3Encoder do
  let(:album) { DuoSplitter::Album.new }
  let(:output_dir) { File.expand_path('~/Desktop/DUO 3.0') }
  let(:ffmpeg_path) { 'ffmpeg' }

  let(:encoder) { described_class.new(output_intro: true, add_section_prefix: true, album: album, output_dir: output_dir, ffmpeg_path: ffmpeg_path) }

  before do
    album.sections.first.source_path = '01 Track 01.wav'
  end

  it "generates a command" do
    expect(encoder.to_commands.first).to eq(['ffmpeg', '-y', '-i', '01 Track 01.wav', '-ss', '0', '-to', '2.960000', '-codec:a', 'libmp3lame', '-q:a', '0', File.expand_path('~/Desktop/DUO 3.0/01-000.mp3')])
  end
end
