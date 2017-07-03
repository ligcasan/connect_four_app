class GameController < ApplicationController
  def index
    @board_height = Game::BOARD_HEIGHT
    @board_width = Game::BOARD_WIDTH
    Game.new
  end

  def place_move
    coordinates = params[:id].split('').map {|x| x.to_i}
    player = params[:player] 
    result = Game.place_move(player, coordinates[0])
    response = {data: result, status: 'success'}.to_json
    render :json => response
  end
end
