Hithr::Application.routes.draw do
  
  constraints(subdomain: "blog") do
    resources :posts, :shallow => true do
      resources :comments
    end
    root :to => 'posts#index'
  end
  
  constraints(subdomain: !"blog" ) do
  
    match "rides/offered" => "rides#offered", :as => "rides_offered"
    match "rides/wanted" => "rides#wanted", :as => "rides_wanted"
    get "users/:user_id/rides" => "rides#user_rides", :as => "user_rides"
    get "/rides" => redirect("/rides/offered")
    match "rides/:id/return" => "rides#return", :as => "return_trip"
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
    
    get 'home_search' => "rides#home_search"
  
  end

end
