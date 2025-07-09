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

  def divide(num1, num2)
    raise ZeroDivisionError, 'Cannot divide by zero' if num2.zero?

    num1.to_f / num2
  end

  def power(base, exponent)
    base**exponent
  end

  def square_root(num)
    raise ArgumentError, 'Cannot calculate the square root of a negative number' if num.negative?

    Math.sqrt(num)
  end
end

# Command-line interface

def prompt(message)
  print message
  gets.chomp
end

calc = Calculator.new

def get_numbers(choice)
  if %w[1 2 3 4 5].include?(choice)
    [prompt('Enter first number: ').to_f, prompt('Enter second number: ').to_f]
  elsif choice == '6'
    [prompt('Enter a number: ').to_f]
  else
    []
  end
end

def calculate(choice, nums, calc)
  case choice
  when '1' then calc.add(*nums)
  when '2' then calc.subtract(*nums)
  when '3' then calc.multiply(*nums)
  when '4'
    begin
      calc.divide(*nums)
    rescue ZeroDivisionError => e
      puts e.message
      nil
    end
  when '5' then calc.power(*nums)
  when '6'
    begin
      calc.square_root(nums.first)
    rescue ArgumentError => e
      puts e.message
      nil
    end
  end
end

def menu
  puts "\nBasic Calculator"
  puts '1. Add'
  puts '2. Subtract'
  puts '3. Multiply'
  puts '4. Divide'
  puts '5. Power'
  puts '6. Square Root'
  puts '7. Exit'
end

loop do
  menu
  choice = prompt('Choose an option: ')
  break if choice == '7'

  nums = get_numbers(choice)
  if nums.empty?
    puts 'Invalid option.'
    next
  end

  result = calculate(choice, nums, calc)
  puts "Result: #{result}" unless result.nil?
end

puts 'Goodbye!'
