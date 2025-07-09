# frozen_string_literal: true

require_relative '../calculator'

RSpec.describe CalculatorApp do
  let(:app) { CalculatorApp.new }
  let(:calculator) { app.instance_variable_get(:@calculator) }

  before do
    # Suppress output to the console during tests
    allow($stdout).to receive(:write)
  end

  describe '#run' do
    it 'performs addition when the user chooses 1' do
      allow(app).to receive(:prompt).and_return('1', '2', '3', '7')
      expect(calculator).to receive(:add).with(2.0, 3.0).and_return(5.0)
      app.run
    end

    it 'performs subtraction when the user chooses 2' do
      allow(app).to receive(:prompt).and_return('2', '5', '3', '7')
      expect(calculator).to receive(:subtract).with(5.0, 3.0).and_return(2.0)
      app.run
    end

    it 'performs multiplication when the user chooses 3' do
      allow(app).to receive(:prompt).and_return('3', '2', '3', '7')
      expect(calculator).to receive(:multiply).with(2.0, 3.0).and_return(6.0)
      app.run
    end

    it 'performs division when the user chooses 4' do
      allow(app).to receive(:prompt).and_return('4', '6', '3', '7')
      expect(calculator).to receive(:divide).with(6.0, 3.0).and_return(2.0)
      app.run
    end

    it 'handles division by zero' do
      allow(app).to receive(:prompt).and_return('4', '5', '0', '7')
      allow(calculator).to receive(:divide).with(5.0, 0.0).and_raise(ZeroDivisionError, 'Cannot divide by zero')
      expect { app.run }.to output(/Error: Cannot divide by zero/).to_stdout
    end

    it 'performs power calculation when the user chooses 5' do
      allow(app).to receive(:prompt).and_return('5', '2', '3', '7')
      expect(calculator).to receive(:power).with(2.0, 3.0).and_return(8.0)
      app.run
    end

    it 'performs square root calculation when the user chooses 6' do
      allow(app).to receive(:prompt).and_return('6', '9', '7')
      expect(calculator).to receive(:square_root).with(9.0).and_return(3.0)
      app.run
    end

    it 'handles invalid input for square root' do
      allow(app).to receive(:prompt).and_return('6', '-1', '7')
      allow(calculator).to receive(:square_root).with(-1.0).and_raise(ArgumentError, 'Cannot calculate the square root of a negative number')
      expect { app.run }.to output(/Error: Cannot calculate the square root of a negative number/).to_stdout
    end

    it 'shows an error for invalid menu choices' do
      allow(app).to receive(:prompt).and_return('8', '7')
      expect { app.run }.to output(/Invalid option./).to_stdout
    end

    it 'exits when the user chooses 7' do
      allow(app).to receive(:prompt).and_return('7')
      expect { app.run }.to output(/Goodbye!/).to_stdout
    end

    it 'handles non-numeric input for numbers' do
      allow(app).to receive(:prompt).and_return('1', 'a', '2', '3', '7')
      expect(calculator).to receive(:add).with(2.0, 3.0).and_return(5.0)
      expect { app.run }.to output(/Invalid number. Please enter a valid number./).to_stdout
    end
  end
end
