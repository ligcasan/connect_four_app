Rails.application.routes.draw do
  root 'game#index'
  
  get 'game/index'

  post 'game/place_move'

end
