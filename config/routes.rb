Insurer::Application.routes.draw do
  root 'stores#show'

  resource :store, only: :show do
    collection do
      get 'tagged(/*tags)' => 'stores#tagged', as: :tagged
    end
  end

  resource :cart, only: [:show, :destroy]
  resources :orders

  devise_for :users

  resources :users, except: [:create] do
    collection do
      get 'new_admin'
      get 'new_moderator'
      get 'new_manager'
      get 'new_quoter'
      get 'new_park'
      get 'new_customer'
      post 'create_admin'
      post 'create_moderator'
      post 'create_manager'
      post 'create_quoter'
      post 'create_park'
      post 'create_customer'
      post 'create_user'
    end
  end

  resources :parks
  resources :companies
  resources :accident_insurances
  resources :health_insurances

  resources :line_items, only: [:index, :show, :edit, :create, :destroy] do
    member do
      put 'commit'
      put 'cancel'
      put 'verify'
      put 'quote'
      put 'reject'
      put 'pay'
      put 'ship'
    end
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
