require 'test_helper'

class GameTest < ActiveSupport::TestCase
  test "Game.new initializes board" do
    assert_nil Game.get_board

    Game.new
    assert Game.get_board == Array.new(Game::BOARD_HEIGHT) {
      Array.new(Game::BOARD_WIDTH, 0)}
  end

  test "Game.place_move sets a player move on the board" do
    Game.place_move(1, 3, 1)
    assert Game.get_board[3][1]
  end

  test "Game.place_move horizontal win" do
    Game.new
    assert !Game.place_move(1, 1, 3)
    assert !Game.place_move(1, 3, 3)
    assert !Game.place_move(1, 4, 3)
    assert Game.place_move(1, 2, 3)
  end

  test "Game.place_move vertical win" do
    Game.new
    assert !Game.place_move(1, 6, 2)
    assert !Game.place_move(1, 6, 3)
    assert !Game.place_move(1, 6, 5)
    assert Game.place_move(1, 6, 4)
  end

  test "Game.place_move left diagonal win" do
    Game.new
    assert !Game.place_move(-1, 4, 2)
    assert !Game.place_move(-1, 5, 3)
    assert !Game.place_move(-1, 3, 1)
    assert Game.place_move(-1, 6, 4)
  end

  test "Game.place_move right diagonal win" do
    Game.new
    assert !Game.place_move(-1, 5, 1)
    assert !Game.place_move(-1, 4, 2)
    assert !Game.place_move(-1, 3, 3)
    assert Game.place_move(-1, 2, 4)
  end

end
