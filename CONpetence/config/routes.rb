CONpetence::Application.routes.draw do

  root 'conventions#browse_cons'

  get '/conventions' => 'conventions#browse_cons' # :as => :cons
  get '/conventions/:con_id' => 'conventions#show' # :as => :con

end