module DuoSplitter
  class AACEncoder < Encoder
    attr_reader :ext, :encoding_options

    def initialize(**)
      super
      @ext = 'm4a'
      @encoding_options = ['-codec:a', 'aac', '-b:a', '256k']
    end
  end
end
