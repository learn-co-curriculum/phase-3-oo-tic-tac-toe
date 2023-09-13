class TicTacToe
    WIN_COMBINATIONS = [
        [0,1,2],
        [3,4,5],
        [6,7,8],
        [0,4,8],
        [2,4,6],
        [0,3,6],
        [1,4,7],
        [2,5,8]
    ]
    def initialize
        @board = Array.new(9, " ")
    end

    def display_board
        puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
        puts "-----------"
        puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
        puts "-----------"
        puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
    end

    def input_to_index(input)
        input = input.to_i - 1
    end

    def move(index, token = "X")
        @board[index] = token
    end

    def position_taken?(index)
        @board[index] != " "
    end

    def valid_move?(index)
        !position_taken?(index) && index.between?(0,9)
    end

    def turn_count
        @board.count {|token| token != " "}
    end

    def current_player
        turn_count % 2 == 0 ? "X" : "O"
    end

    def turn
        input = input_to_index(gets.strip)
        if valid_move?(input)
            move(input, current_player)
            display_board
        else
            turn
        end
        # while !valid_move?(input) do
        #     turn
        # end
        # move(input, current_player)
        # display_board
    end

    def won?
        WIN_COMBINATIONS.find do |combo|
            @board[combo[0]] == @board[combo[1]] &&
            @board[combo[1]] == @board[combo[2]] &&
            position_taken?(combo[0])
        end
    end

    def full?
        @board.all? {|token| token != " "}
    end

    def draw?
        !won? && full?
    end

    def over?
        won? || full? || draw?
    end

    def winner
        won? ? @board[won?[0]] : nil
    end

end