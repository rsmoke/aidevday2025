# frozen_string_literal: true

require 'glimmer-dsl-libui'
require_relative 'calculator'

# Main application window for the calculator.
class CalculatorGui
  include Glimmer
  attr_accessor :display_str

  def initialize
    @calculator = Calculator.new
    self.display_str = '0'
    @current_input = ''
    @previous_input = nil
    @operation = nil
    create_window
  end

  def launch
    @window.show
  end

  private

  def create_window
    @window = window('Calculator', 300, 400) {
      margined true
      vertical_box {
        display_entry
        button_grid
      }
    }
  end

  def display_entry
    @display = entry {
      text <=> [self, :display_str]
      read_only true
    }
  end

  def button_grid
    grid {
      padded true

      # Row 1
      button('^') { left 0; top 0; on_clicked { set_operation(:power) } }
      button('√') { left 1; top 0; on_clicked { calculate_square_root } }

      # Row 2
      button('C') { left 0; top 1; on_clicked { clear_display } }
      button('+/-') { left 1; top 1; on_clicked { toggle_sign } }
      button('%') { left 2; top 1; on_clicked { calculate_percentage } }
      button('/') { left 3; top 1; on_clicked { set_operation(:divide) } }

      # Row 3
      button('7') { left 0; top 2; on_clicked { append_input('7') } }
      button('8') { left 1; top 2; on_clicked { append_input('8') } }
      button('9') { left 2; top 2; on_clicked { append_input('9') } }
      button('*') { left 3; top 2; on_clicked { set_operation(:multiply) } }

      # Row 4
      button('4') { left 0; top 3; on_clicked { append_input('4') } }
      button('5') { left 1; top 3; on_clicked { append_input('5') } }
      button('6') { left 2; top 3; on_clicked { append_input('6') } }
      button('-') { left 3; top 3; on_clicked { set_operation(:subtract) } }

      # Row 5
      button('1') { left 0; top 4; on_clicked { append_input('1') } }
      button('2') { left 1; top 4; on_clicked { append_input('2') } }
      button('3') { left 2; top 4; on_clicked { append_input('3') } }
      button('+') { left 3; top 4; on_clicked { set_operation(:add) } }

      # Row 6
      button('0') { left 0; top 5; xspan 2; on_clicked { append_input('0') } }
      button('.') { left 2; top 5; on_clicked { append_input('.') } }
      button('=') { left 3; top 5; on_clicked { calculate_result } }
    }
  end

  def append_input(char)
    @current_input += char
    self.display_str = @current_input
  end

  def set_operation(op)
    @previous_input = @current_input.to_f
    @current_input = ''
    @operation = op
    self.display_str = "#{@previous_input} #{op_to_char(op)} "
  end

  def calculate_result
    return unless @previous_input && @operation

    second_operand = @current_input.to_f
    result = @calculator.public_send(@operation, @previous_input, second_operand)
    self.display_str = "#{@previous_input} #{op_to_char(@operation)} #{second_operand} = #{result}"
    @current_input = result.to_s
    @previous_input = nil
    @operation = nil
  rescue ZeroDivisionError, ArgumentError => e
    self.display_str = "Error: #{e.message}"
    @current_input = ''
  end

  def clear_display
    self.display_str = '0'
    @current_input = ''
    @previous_input = nil
    @operation = nil
  end

  def toggle_sign
    return if @current_input.empty?

    @current_input = (@current_input.to_f * -1).to_s
    self.display_str = @current_input
  end

  def calculate_percentage
    return if @current_input.empty?

    @current_input = (@current_input.to_f / 100).to_s
    self.display_str = @current_input
  end

  def calculate_square_root
    return if @current_input.empty?

    input_val = @current_input.to_f
    result = @calculator.square_root(input_val)
    self.display_str = "√#{input_val} = #{result}"
    @current_input = result.to_s
  rescue ArgumentError => e
    self.display_str = "Error: #{e.message}"
    @current_input = ''
  end

  def op_to_char(op)
    {
      add: '+',
      subtract: '-',
      multiply: '*',
      divide: '/',
      power: '^'
    }[op]
  end
end

if __FILE__ == $PROGRAM_NAME
  app = CalculatorGui.new
  app.launch
end
