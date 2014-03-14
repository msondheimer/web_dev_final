CONpetence::Application.routes.draw do

  root 'conventions#browse_cons'

  delete '/signout' => 'sessions#destroy'

  get '/conventions/:con_id/photos' => 'conventions#browse_photos'
  get 'conventions/search/results' => 'conventions#search_results'
  get 'conventions/search' => 'conventions#search'
  get '/conventions/:con_id/photos/add' => 'conventions#add_photo'
  get '/conventions' => 'conventions#browse_cons', :as => :cons
  get '/conventions/filter/:genre' => 'conventions#filter'
  get '/conventions/future_conventions' => 'conventions#future_conventions'
  get '/conventions/past_conventions' => 'conventions#past_conventions'
  get '/conventions/new' => 'conventions#new_con_form'
 
  get '/conventions/:con_id' => 'conventions#show', :as => :con

  post '/conventions/filter' => 'conventions#filter'
  post '/conventions/:con_id/photos/newphoto' => 'conventions#new_photo'
  post '/conventions' => 'conventions#create'
  
  get '/photos/:photo_id' => 'photos#show'
  get '/photos' => 'photos#redir_to_cons'

  post '/photos/:photo_id/tagme' => 'photos#tag_user'
  post '/photos/:photo_id/addchar/' => 'photos#addchar', :as => :addchar

  delete '/photos/:photo_id/delete/:chartag' => 'photos#toast_char'
  delete '/photos/:photo_id/delete' => 'photos#toast_photo'
  delete '/photos/:photo_id/untagme' => 'photos#toast_user'
  
  resources :conventions 
  resources :users 
  resources :sessions
  resources :characters, except: [:delete]
  
end