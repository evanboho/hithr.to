Hithr::Application.routes.draw do
  
  resources :rides, :shallow => true do
    resources :details
  end
  
  resources :abouts, :except => [:destroy]
  # match 'about' => 'abouts#index'

  
  resources :authentications, :only => [:new, :create, :destroy]
  match 'users/auth/:provider/callback/' => 'authentications#create'
   
  devise_for :users, :controllers => { :registrations => 'registrations', :sessions => 'users/sessions', :passwords => 'users/passwords' } do
    match "/sign_in" => "users/sessions#new"
    match "/sign_out" => "devise/sessions#destroy" 
    match "/sign_up" => "registrations#new" 
    # match "/users/password/new" => "users/passwords#new"
  end

  resources :users, :shallow => true do
    resources :messages
    resources :profiles
    resources :references
  end
  get 'users/:user_id/messages/sent' => 'messages#sent', :as => "user_sent_messages"
  get 'users/:user_id/messages/all' => 'messages#all', :as => "user_all_messages"
  
  
  root :to => 'pages#home'
  # get "/about" => "pages#about"
  get "/contact" => "pages#contact"
  get "/help" => "pages#help"
  get "/test" => "pages#test"

  get 'users/auth/failure' do # necessary?
    flash[:notice] = params[:message]
    redirect '/'
  end
  
  
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
