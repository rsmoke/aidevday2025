# frozen_string_literal: true

# class Calculator
#
# A simple terminal-based calculator application for Ruby 3.3.4.
#
# Features:
# - Addition, subtraction, multiplication, and division
# - Command-line interface for user interaction
# - Input validation and error handling (e.g., division by zero)
#
# Usage:
#   ruby calculator.rb
#
# Follow the prompts to perform calculations. Enter '5' to exit.

# Performs basic arithmetic operations.
class Calculator
  def add(num1, num2)
    num1 + num2
  end

  def subtract(num1, num2)
    num1 - num2
  end

  def multiply(num1, num2)
    num1 * num2
  end

  # Divides the first number by the second.
  def divide(num1, num2)
    raise ZeroDivisionError, 'Cannot divide by zero' if num2.zero?

    num1.to_f / num2
  end

  # Calculates the power of a number.
  def power(base, exponent)
    base**exponent
  end

  # Calculates the square root of a number.
  def square_root(num)
    raise ArgumentError, 'Cannot calculate the square root of a negative number' if num.negative?

    Math.sqrt(num)
  end
end

# Handles the command-line interface for the calculator.
class CalculatorApp
  OPERATIONS = {
    '1' => { name: 'Add', method: :add, num_args: 2 },
    '2' => { name: 'Subtract', method: :subtract, num_args: 2 },
    '3' => { name: 'Multiply', method: :multiply, num_args: 2 },
    '4' => { name: 'Divide', method: :divide, num_args: 2 },
    '5' => { name: 'Power', method: :power, num_args: 2 },
    '6' => { name: 'Square Root', method: :square_root, num_args: 1 },
    '7' => { name: 'Exit', method: :exit, num_args: 0 }
  }.freeze

  def initialize
    @calculator = Calculator.new
  end

  def run
    loop do
      display_menu
      choice = prompt('Choose an option: ')
      operation = OPERATIONS[choice]

      break if choice == '7'

      if operation
        process_operation(operation)
      else
        puts 'Invalid option.'
      end
    end
    puts 'Goodbye!'
  end

  private

  def display_menu
    puts "\nBasic Calculator"
    OPERATIONS.each do |key, op|
      puts "#{key}. #{op[:name]}"
    end
  end

  def prompt(message)
    print message
    gets.chomp
  end

  def get_numbers(num_args)
    numbers = []
    num_args.times do |i|
      loop do
        num_str = prompt("Enter number #{i + 1}: ")
        begin
          numbers << Float(num_str)
          break
        rescue ArgumentError
          puts 'Invalid number. Please enter a valid number.'
        end
      end
    end
    numbers
  end

  def process_operation(operation)
    nums = get_numbers(operation[:num_args])
    result = @calculator.public_send(operation[:method], *nums)
    puts "Result: #{result}"
  rescue ZeroDivisionError, ArgumentError => e
    puts "Error: #{e.message}"
  end
end

if __FILE__ == $PROGRAM_NAME
  app = CalculatorApp.new
  app.run
end
