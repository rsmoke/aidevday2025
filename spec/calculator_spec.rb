# frozen_string_literal: true

require_relative '../calculator'

RSpec.describe Calculator do
  let(:calc) { Calculator.new }

  describe '#add' do
    it 'returns the sum of two numbers' do
      expect(calc.add(2, 3)).to eq(5)
    end
  end

  describe '#subtract' do
    it 'returns the difference of two numbers' do
      expect(calc.subtract(5, 3)).to eq(2)
    end
  end

  describe '#multiply' do
    it 'returns the product of two numbers' do
      expect(calc.multiply(2, 3)).to eq(6)
    end
  end

  describe '#divide' do
    it 'returns the quotient of two numbers' do
      expect(calc.divide(6, 3)).to eq(2.0)
    end

    it 'raises a ZeroDivisionError when dividing by zero' do
      expect { calc.divide(5, 0) }.to raise_error(ZeroDivisionError, 'Cannot divide by zero')
    end
  end

  describe '#power' do
    it 'returns the result of a number raised to an exponent' do
      expect(calc.power(2, 3)).to eq(8)
    end
  end

  describe '#square_root' do
    it 'returns the square root of a number' do
      expect(calc.square_root(9)).to eq(3.0)
    end

    it 'raises an ArgumentError for a negative number' do
      expect { calc.square_root(-1) }.to raise_error(ArgumentError, 'Cannot calculate the square root of a negative number')
    end
  end
end
