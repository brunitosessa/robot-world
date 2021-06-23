Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      # Cars
      get '/cars/defectives'
      resources :cars, only: [:index, :show]

      # Events
      get '/events/car/:id', to: 'events#by_car'
      get '/events/type/:name', to: 'events#by_type'
      get '/events/model/:model_id', to: 'events#by_car_model'
      resources :events, only: [:index]

      #Statistics
      get '/stats/daily'
    end
  end
end
