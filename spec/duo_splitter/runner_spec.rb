RSpec.describe DuoSplitter::Runner do
  let(:runner) { described_class.new(argv) }

  describe "#output_dir" do
    context "when -d option wasn't given" do
      let(:argv) { [] }

      it "returns default output directory" do
        expect(runner.output_dir.to_s).to eq(File.expand_path('~/Desktop/DUO 3.0'))
      end
    end

    context "when -d option was given" do
      let(:argv) { %w[-d somewhere] }

      it "returns given output directory" do
        expect(runner.output_dir.to_s).to eq('somewhere')
      end
    end
  end

  describe "#format" do
    context "when -f option wasn't given" do
      let(:argv) { [] }

      it "returns default format" do
        expect(runner.format).to eq(:wav)
      end
    end

    context "when valid -f option was given" do
      let(:argv) { %w[-f mp3] }

      it "returns given format" do
        expect(runner.format).to eq(:mp3)
      end
    end

    context "when invalid -f option was given" do
      let(:argv) { %w[-f ogg] }

      it "raises an error" do
        expect { runner.format }.to raise_error(DuoSplitter::Error)
      end
    end
  end

  describe "#output_intro" do
    context "when --[no-]output-intro option wasn't given" do
      let(:argv) { [] }

      it "returns true" do
        expect(runner.output_intro).to be(true)
      end
    end

    context "when --output-intro option was given" do
      let(:argv) { %w[--output-intro] }

      it "returns true" do
        expect(runner.output_intro).to be(true)
      end
    end

    context "when --no-output-intro option was given" do
      let(:argv) { %w[--no-output-intro] }

      it "returns false" do
        expect(runner.output_intro).to be(false)
      end
    end

    context "when --no-section-number option was given" do
      let(:argv) { %w[--no-section-number] }

      it "returns false" do
        expect(runner.output_intro).to be(false)
      end
    end
  end

  describe "#add_section_prefix" do
    context "when --[no-]section-number option wasn't given" do
      let(:argv) { [] }

      it "returns true" do
        expect(runner.add_section_prefix).to eq(true)
      end
    end

    context "when --section-number option was given" do
      let(:argv) { %w[--section-number] }

      it "returns true" do
        expect(runner.add_section_prefix).to eq(true)
      end
    end

    context "when --no-section-number option was given" do
      let(:argv) { %w[--no-section-number] }

      it "returns false" do
        expect(runner.add_section_prefix).to eq(false)
      end
    end
  end

  describe "#ffmpeg_path" do
    context "when --ffmpeg-path option wasn't given" do
      let(:argv) { [] }

      it "returns default ffmpeg path" do
        expect(runner.ffmpeg_path).to eq('ffmpeg')
      end
    end

    context "when --ffmpeg-path option was given" do
      let(:argv) { %w[--ffmpeg-path=/usr/local/bin/ffmpeg] }

      it "returns given ffmpeg path" do
        expect(runner.ffmpeg_path).to eq('/usr/local/bin/ffmpeg')
      end
    end
  end

  describe "handling input file names" do
    context "when a valid file name was given" do
      let(:argv) { ['01 Track 01.wav'] }

      example "source paths were set" do
        expect(runner.album.sections.first.source_path.to_s).to eq('01 Track 01.wav')
      end
    end

    context "when a file name doesn't start with a number" do
      let(:argv) { ['foo.wav'] }

      it "raises an error" do
        expect { runner }.to raise_error(DuoSplitter::Error)
      end
    end

    context "when a file name starts with an invalid section number" do
      let(:argv) { ['99 Track 99.wav'] }

      it "raises an error" do
        expect { runner }.to raise_error(DuoSplitter::Error)
      end
    end
  end
end
