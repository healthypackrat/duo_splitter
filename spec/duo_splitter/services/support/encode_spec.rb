# frozen_string_literal: true

RSpec.describe DuoSplitter::Services::Support::Encode do
  context 'when an unknown output format was given' do
    let(:context) { DuoSplitter::Context.new }
    let(:service) { described_class.new(context: context) }

    before do
      context.output_format = 'ogg'
    end

    it 'raises an error' do
      expect { service.run }.to raise_error(DuoSplitter::Error, /unknown output format:/)
    end
  end
end
