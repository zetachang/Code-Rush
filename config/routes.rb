Blog::Application.routes.draw do
 
  resources :pages do
    get :new_comment, :on => :member
    post :create_comment, :on => :member
    delete :delete_comment, :on => :member
  end

  resources :tutorials do
    get :new_comment, :on => :member
    post :create_comment, :on => :member
    delete :delete_comment, :on => :member 
  end

  root :to => "main#index"
  
  resources :codes do
    get :tags, :on => :collection
    get :all_tags, :on => :collection
    get :my_codes, :on => :collection
  end
  resources :oiers do
     match :update_all, :via => [:get], :on => :collection
     resources :ojees, :except => [:index] 

     resources :tioj_ojees, :except => [:index] do 
       match :update_stat, :via => [:get], :on => :member
     end

     resources :pku_ojees, :except => [:index] do
       match :update_stat, :via => [:get], :on => :member 
     end

     resources :uva_ojees, :except => [:index] do
       match :update_stat, :via => [:get], :on => :member 
     end

     resources :zerojudge_ojees, :except => [:index] do
       match :update_stat, :via => [:get], :on => :member 
     end
  end
 
  
  devise_for :users
  resources :users, :only => [:destroy]
  match 'admin' => 'admin#index', :as => "admin" 
  
  
  resources :assignments do
    resources :assign_items, :as => :items do
      match :hand_in, :via => [:post], :on => :member  
    end
    resources :assign_items
    get 'assigned_to_me', :on => :collection
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
  

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
