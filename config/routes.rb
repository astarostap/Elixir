Rails.application.routes.draw do
  root 'questions#index'

  get 'users/login' => 'users#login'
  post 'users/post_login' => 'users#post_login'
  get 'users/logout' => 'users#logout'

  post 'questions/query' => 'questions#query'
  post 'questions/option_vote' => 'questions#option_vote'
  get 'questions/query_votes' => 'questions#query_votes'

  resources :questions
  resources :users


end
