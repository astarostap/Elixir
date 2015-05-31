Rails.application.routes.draw do
  root 'questions#index'

  get 'users/login' => 'users#login'
  post 'users/post_login' => 'users#post_login'
  get 'users/logout' => 'users#logout'

  post 'questions/query' => 'questions#query'
  get 'questions/show_paper' => 'questions#show_paper'
  post 'questions/create_paper' => 'questions#create_paper'
  post 'questions/create_comment' => 'questions#create_comment'
  post 'questions/create_agree' => 'questions#create_agree'
  post 'questions/create_video' => 'questions#create_video'


  post 'questions/option_vote' => 'questions#option_vote'
  get 'questions/query_votes' => 'questions#query_votes'

  resources :questions
  resources :users


end
