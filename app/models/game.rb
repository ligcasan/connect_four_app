class Game < ApplicationRecord
  BOARD_HEIGHT = 6
  BOARD_WIDTH = 7

  WINNING_LENGTH = 4

  def self.new
    @board = Array.new(BOARD_HEIGHT) {Array.new(BOARD_WIDTH, 0)}
  end

  def self.get_board
    return @board
  end

  def self.place_move(player=0, x_coordinate, y_coordinate)
    @board[y_coordinate][x_coordinate] = player
    return Game.is_winner(player, x_coordinate, y_coordinate)
  end

  def self.is_winner(player=0, x_coordinate, y_coordinate)
    winning_combo = "#{player}" * WINNING_LENGTH

    horizontal_combo = @board[y_coordinate].join()
    if horizontal_combo[winning_combo] != nil
      return true
    end

    vertical_combo = @board.map{|i| i[x_coordinate]}.join()
    if vertical_combo[winning_combo] != nil
      return true
    end

    upper_diagonal = []
    i = x_coordinate + 1
    j = y_coordinate - 1
    while i < BOARD_WIDTH && j >= 0 do
      upper_diagonal.push(@board[j][i])
      i += 1
      j -= 1
    end

    lower_diagonal = []
    i = x_coordinate - 1
    j = y_coordinate + 1
    while i >= 0 && j < BOARD_HEIGHT do
      lower_diagonal.insert(0, @board[j][i])
      i -= 1
      j += 1
    end

    right_diagonal_combo = lower_diagonal + [player] + upper_diagonal
    right_diagonal_combo = right_diagonal_combo.join()
    if right_diagonal_combo[winning_combo] != nil
      return true
    end

    upper_diagonal = []
    i = x_coordinate - 1
    j = y_coordinate - 1
    while i >= 0 && j >= 0 do
      upper_diagonal.push(@board[j][i])
      i -= 1
      j -= 1
    end

    lower_diagonal = []
    i = x_coordinate + 1
    j = y_coordinate + 1
    while i < BOARD_WIDTH && j < BOARD_HEIGHT do
      lower_diagonal.insert(0, @board[j][i])
      i += 1
      j += 1
    end

    left_diagonal_combo = lower_diagonal + [player] + upper_diagonal
    left_diagonal_combo = left_diagonal_combo.join()
    if left_diagonal_combo[winning_combo] != nil
      return true
    end

    return false
  end

end
