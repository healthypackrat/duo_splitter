# frozen_string_literal: true

RSpec.describe DuoSplitter::Runner do
  let(:runner) { described_class.new(argv) }

  describe '#run' do
    context 'when an unknown command name was given' do
      let(:argv) { ['unknown_command_name'] }

      it 'raises an error' do
        expect { runner.run }.to raise_error(DuoSplitter::Error, /unknown command:/)
      end
    end

    context 'when a known command name was given' do
      let(:command_name) { 'known_command_name' }
      let(:argv) { [command_name] }

      before do
        command_instance = double('command instance', run: nil)
        command_class = double('command class')
        allow(command_class).to receive(:new).and_return(command_instance)
        described_class.register_command(command_name, command_class)
      end

      it "doesn't raise an error" do
        expect { runner.run }.not_to raise_error
      end
    end

    context "when a command wasn't given" do
      let(:argv) { [] }

      it 'shows usage' do
        expect { runner.run }.to output(/Usage:/).to_stdout
      end
    end
  end

  describe '.register_command' do
    let(:command_class) { double('command class') }

    before do
      described_class.register_command(:name, command_class)
    end

    it 'has a command' do
      expect(described_class.known_commands[:name]).to eq(command_class)
    end
  end
end
