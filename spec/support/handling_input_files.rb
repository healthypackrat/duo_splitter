# frozen_string_literal: true

RSpec.shared_context 'handling input files' do
  describe 'handling input files' do
    context 'when no input files were given' do
      let(:argv) { [] }

      it 'raises an error' do
        expect { command }.to raise_error(DuoSplitter::Error, 'no input files were given')
      end
    end

    context "when an input file name doesn't start with a number" do
      let(:argv) { ['Track 01.wav'] }

      it 'raises an error' do
        expect { command }.to raise_error(DuoSplitter::Error, /input file name doesn't start with a number:/)
      end
    end

    context 'when an input file name starts with an invalid section number' do
      let(:argv) { ['99 Track 99.wav'] }

      it 'raises an error' do
        expect { command }.to raise_error(DuoSplitter::Error, /invalid section number:/)
      end
    end
  end
end
