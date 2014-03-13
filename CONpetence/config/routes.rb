CONpetence::Application.routes.draw do

  root 'conventions#browse_cons'

  get 'conventions/search/results' => 'conventions#search_results'

  get 'conventions/search' => 'conventions#search'

  post '/photos/:photo_id/addchar/' => 'photos#tag_char', :as => :addchar

  delete '/photos/:photo_id/delete/:chartag' => 'photos#toast_char'
  delete '/photos/:photo_id/delete' => 'photos#toast_photo'

  post '/conventions/filter' => 'conventions#filter'
  post '/conventions/:con_id/photos/newphoto' => 'conventions#new_photo'
  get '/conventions/:con_id/photos/add' => 'conventions#add_photo'
  get '/photos/:photo_id' => 'photos#view_photo'
  get '/photos' => 'photos#redir_to_cons'
  get '/conventions' => 'conventions#browse_cons', :as => :cons

  get '/conventions/filter/:genre' => 'conventions#filter'


  get '/users/new' => 'users#new_user_form'
  get '/conventions/new' => 'conventions#new_con_form'

  get '/conventions/:con_id/photos' => 'conventions#browse_photos'
  get '/conventions/:con_id' => 'conventions#show', :as => :con

  post '/conventions' => 'conventions#create'
  get "/logout" => "sessions#destroy", as: 'logout'
  
  delete '/photos/:photo_id/untagme' => 'photos#toast_user'
  post '/photos/:photo_id/tagme' => 'photos#tag_user'

  get '/users/edit/:id' => 'users#edit'
  patch '/users/update/:id' => 'users#update'

  resources :users, only: [:new, :create, :show]
  resources :sessions


  
end