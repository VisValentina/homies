Rails.application.routes.draw do
  get 'about', to: "static_pages#about", as: "about"
  get 'invite', to: "static_pages#invite", as: "invite"
  post 'invite/email_invite', to: "static_pages#email_invite", as: "email_invite"

  get 'categories/index'

  get 'categories/new'

  get 'categories/show'

  get 'categories/edit'

  get 'expenses/index'

  get 'expenses/show'

  root "sessions#login"
  get 'login', to: "sessions#login", as: "login"
  post 'login', to: "sessions#attempt_login"
  delete 'logout', to: "sessions#logout", as: "logout"

  resources :users do
    resources :spheres do
      resources :expenses, shallow: true
    end
  end

  get 'spheres/:sphere_id/connections', to: "connections#index", as: "connections"
  get 'spheres/:sphere_id/connections/new', to: "connections#new", as: "new_connection"
  get 'spheres/:sphere_id/connections/edit', to: "connections#edit", as: "edit_connections"
  delete 'spheres/:sphere_id/connections/:id', to: "connections#destroy", as: "delete_connection"
  # resources :connections
  resources :categories
  resources :resets, only: [:new, :edit, :create, :update]

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
