# frozen_string_literal: true

RSpec.describe DuoSplitter::Commands::OverlappingCommand do
  let(:argv) { ['01 Track 01.wav'] }
  let(:command) { described_class.new(argv) }

  include_context 'parsing common options'
  include_context 'parsing concatenating options'
  include_context 'handling input files'

  it 'outputs to "~/Desktop/DUO 3.0 (Overlapping)" by default' do
    expect(command.context.output_dir.to_s).to eq(File.expand_path('~/Desktop/DUO 3.0 (Overlapping)'))
  end
end
