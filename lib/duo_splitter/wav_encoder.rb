module DuoSplitter
  class WAVEncoder < Encoder
    attr_reader :ext, :encoding_options

    def initialize(**)
      super
      @ext = 'wav'
      @encoding_options = ['-codec:a', 'pcm_s16le']
    end
  end

  Encoder.register(:wav, WAVEncoder)
end
