module DuoSplitter
  class MP3Encoder < Encoder
    attr_reader :ext, :encoding_options

    def initialize(**)
      super
      @ext = 'mp3'
      @encoding_options = ['-codec:a', 'libmp3lame', '-q:a', '0']
    end
  end
end
