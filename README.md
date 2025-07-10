# Ruby Calculator

A simple calculator application written in Ruby, with both terminal-based and GUI interfaces.

## Description

This project contains two versions of a calculator:

- A command-line tool that performs basic and some advanced arithmetic operations. It provides an interactive menu to guide the user through the available calculations.
- A graphical user interface (GUI) version with a more user-friendly layout.

## Installation

To run either version of the calculator, you need to have Ruby installed.

1. Clone the repository or download the source code.
2. Open your terminal and navigate to the project directory.
3. Install the required gems:

    ```bash
    bundle install
    ```

## Usage

### Terminal Version

To run the terminal-based calculator, run the following command in your terminal:

```bash
ruby calculator.rb
```

### GUI Version

To run the GUI calculator, use this command:

```bash
ruby calculator_gui.rb
```

## Features

The calculator supports the following operations:

- **Addition**: Adds two numbers.
- **Subtraction**: Subtracts the second number from the first.
- **Multiplication**: Multiplies two numbers.
- **Division**: Divides the first number by the second.
- **Power**: Raises the first number to the power of the second number.
- **Square Root**: Calculates the square root of a number.

## Instructions

1. Run the application using the command `ruby calculator.rb`.
2. You will see a menu with a list of operations.
3. Enter the number corresponding to the operation you want to perform.
    - For **Addition**, **Subtraction**, **Multiplication**, **Division**, and **Power**, you will be prompted to enter two numbers.
    - For **Square Root**, you will be prompted to enter one number.
4. The calculator will display the result.
5. The menu will be displayed again for another calculation.
6. To exit the application, choose the 'Exit' option from the menu.

### Error Handling

The calculator includes basic error handling:

- It will display an error message if you attempt to divide by zero.
- It will display an error message if you attempt to calculate the square root of a negative number.
- It will show an "Invalid option" message if you select a choice not in the menu.
