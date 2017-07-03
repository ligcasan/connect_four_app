class Game < ApplicationRecord
  BOARD_HEIGHT = 6
  BOARD_WIDTH = 7

  WINNING_LENGTH = 4

  def self.new
    # Initializes a new Game class
    # 
    # param:
    # nil
    # return:
    # array @board - a 6x7 array whose cells are initialized to 0.
    #                It is a table that records the players' moves
    
    @board = Array.new(BOARD_WIDTH) {Array.new(BOARD_HEIGHT, 0)}
    return @board
  end

  def self.get_board
    # Returns the current state of the class variable @board
    #
    # param:
    # nil
    # return:
    # array @board - a table that records the players' moves

    return @board
  end

  def self.place_move(player=0, x_coordinate)
    # Records the player's move to @board
    # base on the final x and y coordinates.
    #
    # param:
    # int player - determines which player placed the move
    # int x_coordinate - column where the user wishes to place his move 
    # return:
    # array [:nex_x, :new_y, :status] - provides the final coordinate
    # for the player's move and determines if a winning combination was created

    y_coordinate = Game.get_final_y_coordinate(x_coordinate)
    @board[x_coordinate][y_coordinate] = player
    return Game.is_winner(player, x_coordinate, y_coordinate)
  end

  def self.get_final_y_coordinate(x_coordinate)
    # Searches for the first empty cell in the given column
    #
    # param:
    # int x_coordinate - column where the user wishes to place his move
    # return
    # int - first empty array index

    column = @board[x_coordinate]
    return column.index(0)
  end

  def self.is_winner(player=0, x_coordinate, y_coordinate)
    # Determines if a winning combination was created with the coordinates
    #
    # param:
    # int player - determines which player placed the move
    # int x_coordinate - column where the move is placed
    # int y_coordinate - row where the move is placed
    # result:
    # boolean - true if a winning combination is present, otherwise false

    winning_combo = "#{player}" * WINNING_LENGTH

    vertical_combo = @board[x_coordinate].join()
    if vertical_combo[winning_combo] != nil
      return {new_x: x_coordinate, new_y: y_coordinate, status: 'win'}
    end

    horizontal_combo = @board.map{|i| i[y_coordinate]}.join()
    if horizontal_combo[winning_combo] != nil
      return {new_x: x_coordinate, new_y: y_coordinate, status: 'win'}
    end

    upper_diagonal = []
    i = x_coordinate + 1
    j = y_coordinate + 1
    while i < BOARD_WIDTH && j < BOARD_HEIGHT do
      upper_diagonal.push(@board[i][j])
      i += 1
      j += 1
    end

    lower_diagonal = []
    i = x_coordinate - 1
    j = y_coordinate - 1
    while i >= 0 && j >= 0 do
      lower_diagonal.insert(0, @board[i][j])
      i -= 1
      j -= 1
    end

    right_diagonal_combo = lower_diagonal + [player] + upper_diagonal
    right_diagonal_combo = right_diagonal_combo.join()
    if right_diagonal_combo[winning_combo] != nil
      return {new_x: x_coordinate, new_y: y_coordinate, status: 'win'}
    end

    upper_diagonal = []
    i = x_coordinate - 1
    j = y_coordinate + 1
    while i >= 0 && j < BOARD_HEIGHT do
      upper_diagonal.push(@board[i][j])
      i -= 1
      j += 1
    end

    lower_diagonal = []
    i = x_coordinate + 1
    j = y_coordinate - 1
    while i < BOARD_WIDTH && j >= 0 do
      lower_diagonal.insert(0, @board[i][j])
      i += 1
      j -= 1
    end

    left_diagonal_combo = lower_diagonal + [player] + upper_diagonal
    left_diagonal_combo = left_diagonal_combo.join()
    if left_diagonal_combo[winning_combo] != nil
      return {new_x: x_coordinate, new_y: y_coordinate, status: 'win'}
    end

    return {new_x: x_coordinate, new_y: y_coordinate, status: false}
  end

end
