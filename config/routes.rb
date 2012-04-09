Hithr::Application.routes.draw do

  match "/my_rides" => "rides#user", :as => "user_rides"
  get "rides/wanted" => "rides#index_wanted", :as => "rides_wanted"
  resources :rides, :shallow => true do
    resources :details
  end

  resources :abouts, :except => [:destroy], :path => "/about"
  
  resources :authentications, :only => [:new, :create, :destroy]
  match 'users/auth/:provider/callback/' => 'authentications#create'
   
  devise_for :users, :controllers => {  :registrations => 'registrations', 
                                        :sessions => 'users/sessions', 
                                        :passwords => 'users/passwords' } do
    match "/sign_in" => "users/sessions#new"
    match "/sign_out" => "devise/sessions#destroy" 
    match "/sign_up" => "registrations#new" 
  end
  
  resources :users, :shallow => true do
    resources :messages
    resources :profiles
    resources :references
  end
  get 'users/:user_id/messages/sent' => 'messages#sent', :as => "user_sent_messages"
  get 'users/:user_id/messages/all' => 'messages#all', :as => "user_all_messages"
  
  
  root :to => 'pages#home'
  get "/contact" => "pages#contact"
  get "/help" => "pages#help"
  get "/test" => "pages#test"
  get "/send_contact" => "pages#send_contact", :as => "send_contact"

  get 'users/auth/failure' do
    flash[:notice] = params[:message]
    redirect '/'
  end

end
