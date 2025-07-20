require 'pry'

class TicTacToe
  attr_accessor :board

  WIN_COMBINATIONS = [
    [0, 1, 2], # Top row
    [3, 4, 5], # Middle row
    [6, 7, 8], # Bottom row
    [0, 3, 6], # Left column
    [1, 4, 7], # Middle column
    [2, 5, 8], # Right column
    [0, 4, 8], # First diagonal
    [2, 4, 6] # Second diagnoal
  ]

  def initialize
    @board = [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ']
  end

  def display_board
    puts " #{board[0]} | #{board[1]} | #{board[2]} "
    puts '-----------'
    puts " #{board[3]} | #{board[4]} | #{board[5]} "
    puts '-----------'
    puts " #{board[6]} | #{board[7]} | #{board[8]} "
  end

  def input_to_index(input)
    raise ArgumentError if input.nil?

    input.to_i - 1
  end

  def valid_move?(input)
    (0..8).include?(input.to_i) && !position_taken?(input.to_i)
  end

  def move(move_location, player_token = 'X')
    board[move_location] = player_token
  end

  def position_taken?(move_location)
    board[move_location] != ' '
  end

  def turn_count
    board.count { |value| value != ' ' }
  end

  def current_player
    turn_count.even? ? 'X' : 'O'
  end

  def turn
    loop do
      print 'Enter an open position 1-9 to make your move: '
      user_input = gets.chomp

      begin
        user_move = input_to_index(user_input)
        raise MoveError unless valid_move?(user_move)

        move(user_move, current_player)
        display_board
        break
      rescue MoveError => e
        puts e.message
      end
    end
  end

  def won?
    WIN_COMBINATIONS.find do |combo|
      board[combo[0]] == board[combo[1]] && board[combo[1]] == board[combo[2]] && board[combo[0]] != ' '
    end
  end

  def full?
    !board.include?(' ')
  end

  def draw?
    full? && !won?
  end

  def over?
    won? || full? || draw?
  end

  def winner
    board[won?[0]] if won?
  end

  def play
    turn until over?
    if won?
      puts "Congratulations #{winner}!"
    elsif draw?
      puts "Cat's Game!"
    end
  end
end

class MoveError < StandardError
  def message
    'Invalid move! Please enter a number between 1 and 9.'
  end
end
