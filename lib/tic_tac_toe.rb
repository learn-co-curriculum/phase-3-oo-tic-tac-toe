require "pry"

class TicTacToe
  WIN_COMBINATIONS = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [6,4,2]]

  attr_writer :board

  def initialize
   @board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
 end

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index position
    position.to_i - 1
  end

  def move index, token = "X"
    @board[index] = token
  end

  def position_taken?(index)
    @board[index] != " "
  end

  def valid_move?(index)
    index.between?(0, 8) && !position_taken?(index)
  end

  def turn_count
    @board.filter {|p| p != " "}.length
  end

  def current_player
   turn_count.even? ? "X" : "O"
  end

  def turn
    puts "It is #{current_player}'s turn. Please input a move selection"
    index = input_to_index(gets)
    if valid_move? index
      move index, current_player
      display_board
    else
      turn

    end
  end

  def won?
    WIN_COMBINATIONS.detect do |combo|
      if (@board[combo[0]] == @board[combo[1]] &&
          @board[combo[1]] == @board[combo[2]] &&
          @board[combo[0]] != " ")
        combo
      end
    end
  end

  def full?
    @board.filter {|i| i == " "}.length == 0
  end

  def draw?
    full? && !won?
  end

  def over?
    won? || draw?
  end

  def winner
    if draw? || !over?
      return nil
    else
      @board[won?[0]]
    end
  end

  def play
    until over?
      turn
    end

    if won?
      puts "Congratulations #{winner}!"
    elsif draw?
      puts "Cat's Game!"
    end
  end
end


game1 = TicTacToe.new

binding.pry

game1.display_board
