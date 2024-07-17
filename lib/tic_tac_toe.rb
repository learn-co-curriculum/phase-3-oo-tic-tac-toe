class TicTacToe
  attr_accessor :board, :player

  WIN_COMBINATIONS = [
    [0, 1, 2], # Top row
    [3, 4, 5], # Middle row
    [6, 7, 8], # Bottom row
    [0, 3, 6], # Left column
    [1, 4, 7], # Middle column
    [2, 5, 8], # Right column
    [0, 4, 8], # Diagonal from top-left to bottom-right
    [2, 4, 6]  # Diagonal from top-right to bottom-left
  ]

  def initialize
    @board = Array.new(9, " ")
    @player
  end

  def display_board
    puts " #{board[0..2].join(" | ")} \n-----------\n #{board[3..5].join(" | ")} \n-----------\n #{board[6..8].join(" | ")} "
  end
  
  def input_to_index(input)
    input.to_i - 1
  end

  def move(board_index, token=@player)
    @board[board_index] = token
  end

  def position_taken?(position_to_take)
    @board[position_to_take] == " " ? false : true
  end

  def valid_move?(position_to_take)
    if position_to_take == -1
      false
    elsif @board[position_to_take] && !position_taken?(position_to_take)
      true
    else
      false
    end
  end

  def turn_count
    board.filter { |position| position != " " }.count
  end

  def current_player
    player_X = board.filter { |position| position == "X" }.count
    player_O = board.filter { |position| position == "O" }.count
    player_X > player_O ? @player = "O" : @player = "X"
  end

  def turn
    puts "Please enter a position (1-9) player #{@player}: "
    input = gets
    index_for_move = input_to_index(input)
    if valid_move?(index_for_move)
      current_player
      move(index_for_move)
      display_board
    else
      puts "invalid"
      turn
    end
  end

  def won?
    won = false
    WIN_COMBINATIONS.each do |combination|
      if @board[combination[0]] == @board[combination[1]] &&
         @board[combination[1]] == @board[combination[2]] &&
         @board[combination[0]] != " "
          won = combination
      end
    end
    won
  end

  def full?
    @board.none? { |x| x == " " }
  end

  def draw?
    full? == true && won? == false
  end

  def over?
    full? == true || won? == true
  end

  def winner
    if (winning_combination = won?)
      @board[winning_combination[0]]
    end
  end

  def play
    until over? || draw? || full? || won?  
      turn
      won?
    end

    if won?
      puts "Congratulations #{winner}!"
    elsif draw?
      puts "Cat's Game!"
    end
  end
end
