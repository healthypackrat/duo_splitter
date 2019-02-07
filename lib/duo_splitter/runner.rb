require 'optparse'
require 'pathname'

module DuoSplitter
  class Runner
    attr_reader :output_dir, :format, :output_intro, :add_section_prefix, :ffmpeg_path, :album

    def initialize(argv)
      @output_dir = Pathname.new('~/Desktop/DUO 3.0').expand_path
      @format = :wav
      @known_formats = Encoder.known_encoders.keys.sort
      @output_intro = true
      @add_section_prefix = true
      @ffmpeg_path = 'ffmpeg'
      @album = Album.new

      parse_options(argv)
      handle_source_paths(argv)
    end

    def run
      encoder_class = Encoder.known_encoders[@format]

      encoder = encoder_class.new(
        album: @album,
        output_dir: @output_dir,
        output_intro: @output_intro,
        add_section_prefix: @add_section_prefix,
        ffmpeg_path: @ffmpeg_path
      )

      encoder.run
    end

    private

    def parse_options(argv)
      parser = OptionParser.new

      parser.banner = %(Usage: #{File.basename($PROGRAM_NAME)} [options] "01 Track 01.wav" "02 Track 02.wav" ... "45 Track 45.wav")

      parser.on('-d', '--output-dir=PATH', "Output directory (default: #{@output_dir})") do |value|
        @output_dir = Pathname.new(value)
      end

      parser.on('-f', '--format=FORMAT', @known_formats, "Output format (default: #{@format}; one of #{@known_formats.join(', ')})") do |value|
        @format = value.to_sym
      end

      parser.on('--[no-]output-intro', "Output intro track (default: #{@output_intro})") do |flag|
        @output_intro = flag
      end

      parser.on('--[no-]section-number', "Add section number to output name (default: #{@add_section_prefix})") do |flag|
        @add_section_prefix = flag
      end

      parser.on('--ffmpeg-path=PATH', "Path to ffmpeg command (default: #{@ffmpeg_path})") do |value|
        @ffmpeg_path = value
      end

      begin
        parser.parse!(argv)
      rescue OptionParser::ParseError => error
        raise Error, error.message
      end

      unless @add_section_prefix
        @output_intro = false
      end
    end

    def handle_source_paths(argv)
      argv.each do |source_path|
        source_path = Pathname.new(source_path)

        if /\A(\d+)/ =~ source_path.basename.to_s
          section_number = $1.to_i

          section = @album.sections.find {|section| section.number == section_number }

          if section
            section.source_path = source_path
          else
            raise Error, "invalid section number: #{section_number}"
          end
        else
          raise Error, "input file name doesn't start with a section number: #{source_path}"
        end
      end
    end
  end
end
