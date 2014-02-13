CONpetence::Application.routes.draw do

  root 'conventions#browse_cons'

  get '/conventions/:con_id/photos/newphoto' => 'conventions#new_photo'
  get '/conventions/:con_id/photos/add' => 'conventions#add_photo'
  get '/conventions' => 'conventions#browse_cons', :as => :cons
<<<<<<< HEAD

=======
  get '/conventions/new' => 'conventions#new_con_form'
>>>>>>> dandev
  get '/conventions/:con_id/photos' => 'conventions#browse_photos'
  get '/conventions/:con_id' => 'conventions#show', :as => :con

  post '/conventions' => 'conventions#create'
  
end