Followgen::Application.routes.draw do

  resources :users
  resources :terms do
    get :preview, on: :member
  end

  # Sessions
  resources :sessions, only: [ :new, :create, :destroy ]
  get '/login' => 'sessions#new'
  get '/logout' => 'sessions#destroy'

  # OAuth
  get 'auth/:provider/callback', to: 'users#add_oauth'
  get 'auth/failure', to: redirect('/')

  root to: 'stats#index'

end
