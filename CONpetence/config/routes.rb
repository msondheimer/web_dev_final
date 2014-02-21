CONpetence::Application.routes.draw do

  root 'conventions#browse_cons'

  get '/convention/search' => 'conventions#search'
  post '/conventions/:con_id/photos/newphoto' => 'conventions#new_photo'
  get '/conventions/:con_id/photos/add' => 'conventions#add_photo'
  get '/photos/:photo_id' => 'photos#view_photo'
  get '/photos' => 'photos#redir_to_cons'
  get '/conventions' => 'conventions#browse_cons', :as => :cons



  get '/conventions/new' => 'conventions#new_con_form'

  get '/conventions/:con_id/photos' => 'conventions#browse_photos'
  get '/conventions/:con_id' => 'conventions#show', :as => :con

  post '/conventions' => 'conventions#create'
  
end