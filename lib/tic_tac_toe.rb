require 'pry'
class TicTacToe
  WIN_COMBINATIONS = [
    [0, 1, 2], [3, 4, 5], [6, 7, 8],
    [0, 3, 6], [1, 4, 7], [2, 5, 8],
    [0, 4, 8], [2, 4, 6]
  ].freeze
  BOARD_OF_POSITIONS = %w[1 2 3 4 5 6 7 8 9].freeze

  def initialize
    @board = [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ']
  end

  def display_board(board = @board)
    nested_board(board).each.with_index do |row, i|
      format_displayed_row row, i
    end
    @board
  end

  def input_to_index(input)
    input.to_i - 1
  end

  def move(position, token = 'X')
    @board[position] = token
  end

  def position_taken?(index)
    @board[index] != ' '
  end

  def valid_move?(position)
    position.between?(0, 8) & !position_taken?(position)
  end

  def turn_count
    @board.reject { |pos| pos == ' ' }.length
  end

  def current_player
    turn_count.even? ? 'X' : 'O'
  end

  def turn
    puts 'Please enter 1-9:'
    index = input_to_index(gets.chomp)
    if valid_move?(index)
      move(index, current_player)
      display_board
      # puts 'Board Space Numbers:'
      # display_board(BOARD_OF_POSITIONS)
    else
      turn
    end
  end

  def won?
    WIN_COMBINATIONS.find do |combo|
      @board[combo[0]] != ' ' && @board[combo[0]] == @board[combo[1]] && @board[combo[1]] == @board[combo[2]]
    end
  end

  def full?
    @board.none? { |space| space == ' ' }
  end

  def draw?
    full? && !won?
  end

  def over?
    draw? || won?
  end

  def winner
    won? && @board[won?[0]]
  end

  def play
    turn until over?
    if winner
      puts "Congratulations #{winner}!"
    elsif draw?
      puts "Cat's Game!"
    end
  end

  private

  def nested_board(board)
    new_board = []
    0.step(8, 3) { |index| new_board << board[index, 3] }
    new_board
  end

  def format_displayed_row(row, index)
    case index
    when 0, 1
      display_row(row)
      puts '-----------'
    when 2 then display_row(row)
    end
  end

  def display_row(row)
    puts " #{row[0]} | #{row[1]} | #{row[2]} "
  end
end
