Insuretown::Application.routes.draw do
  root 'stores#show'

  mount ChinaCity::Engine => '/china_city'

  resource :store, only: :show do
    collection do
      get 'tagged(/*tags)' => 'stores#tagged', as: :tagged
    end
  end

  resource :cart, only: [:show, :destroy]
  resources :orders do
    member do
      put 'pay'
      put 'ship'
      put 'cancel'
    end
  end

  devise_for :users

  resources :users, only: [:index, :show, :destroy]

  resources :admin_profiles, only: [:new, :edit, :create, :update, :destroy]
  resources :moderator_profiles, only: [:new, :edit, :create, :update, :destroy]
  resources :manager_profiles, only: [:new, :edit, :create, :update, :destroy]
  resources :quoter_profiles, only: [:new, :edit, :create, :update, :destroy]
  resources :park_profiles, only: [:new, :edit, :create, :update, :destroy]
  resources :customer_profiles, only: [:new, :edit, :create, :update, :destroy]

  resources :contacts

  resources :parks
  resources :companies
  resources :insurances
  resources :accident_insurances
  resources :public_liability_insurances
  resources :product_liability_insurances
  resources :employer_liability_insurances
  resources :health_insurances

  resources :line_items, only: [:index, :show, :create, :destroy] do
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

  resources :accident_items do
    collection do
      post 'add_to_cart'
    end
  end
  resources :public_liability_items do
    collection do
      post 'add_to_cart'
    end
  end
  resources :product_liability_items do
    collection do
      post 'add_to_cart'
    end
  end
  resources :employer_liability_items do
    collection do
      post 'add_to_cart'
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
