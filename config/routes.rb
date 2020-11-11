SessionExample::Application.routes.draw do
  get "/setting" => 'setting#index'
  get "/contact" => 'contact#index'
  
  devise_for :users, controllers: { sessions: 'user_login'}
  root "home#index"
  resources :logins, only: [:destroy]
  get '/logins_sessions' => 'logins#index', as: :logins_session
end
