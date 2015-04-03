Rails.application.routes.draw do
  # instead users#new
  resources :users, :except => ["new"]
  get '/signup'=> 'users#new', :as => 'signup'

  resources :bands do
    get :autocomplete_name, on: :collection
  end
  # Landing page allow users to add bands to their
  # tracked bands
  root 'bands#new'
  resources :events

  get 'login' => 'sessions#new'
  get 'logout' => 'sessions#destroy'
  post 'sessions' => 'sessions#create'
  post 'user_bands' => 'user_bands#create'
  delete 'user_bands' => 'user_bands#destroy'
  # sends the id of the band the user clicked on to the bands#event controller
  post 'bands/events' => 'bands#events'
  get "/auth/facebook/callback" => 'sessions#create'
end
