Rails.application.routes.draw do
  root :to => 'pages#index'

  resources :teams
  resources :users
  resources :clubs
  resources :grounds
  resources :matches

  get '/dashboard' => 'pages#dashboard', :as=> 'dashboard'
  get '/navigator' => 'pages#navigator', :as => 'navigator'
  get '/chart_tester' => 'pages#chart_test'

  #login
  get '/login' => 'session#new'
  post '/login' => 'session#create'
  delete '/login' => 'session#destroy'

  #custom paths for favourites - as they should appear under user
  get 'users/:id/favs/new', :to => redirect('/navigator')
  get 'users/:id/favs/new/:team_id' => 'favs#new', :as=> 'new_fav'
  get 'users/:id/favs/:fav_id' => 'favs#show', :as => 'fav'
  delete 'users/:id/favs/:fav_id' => 'favs#destroy', :as => 'delete_fav'
  get 'users/:id/favs/:fav_id/edit' => 'favs#edit', :as => 'edit_fav'
  get 'users/:id/favs/index' => 'favs#index', :as => 'favs'
  post 'users/:id/favs/:team_id' => 'favs#create'
  patch 'users/:id/favs/:fav_id' => 'favs#update', :as => 'update_fav'

  #paths for age groups and divisions
  get '/teams/:id/results' => 'teams#results', :as => 'team_results'


  get '/teams/:id/fixtures' => 'teams#fixtures', :as => 'team_fixtures'
  get '/teams/:a/:b' => 'teams#matchup', :as => 'matchup'

  get '/:age_group/:division/results' => 'pages#division_results', :as => 'division_results'

  get '/:age_group/:division/fixtures' => 'pages#division_fixtures', :as=> 'division_fixtures'

  get '/:age_group/:division/:id', :to => redirect('/teams/%{id}')
  get '/:age_group/:division' => 'pages#division', :as=> 'division'

  get '/:age_group' => 'pages#age_group', :as=> 'age_group'

end
