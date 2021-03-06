Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'

  get 'signup' => 'users#new', as: :signup
  post 'signup' => 'users#create', as: :new_user
  get 'login' => 'session#new', as: :login
  post 'login' => 'session#create', as: :sessions
  delete 'logout' => 'session#destroy', as: :logout

  get 'import' => 'import#index', as: :import_index
  post 'import' => 'import#import', as: :import
  post 'import/upload' => 'import#upload', as: :import_upload
  get 'stats/last' => 'stats#last', as: :stats_last
  get 'compare' => 'stats#compare', as: :stats_compare

  resources :stats, execpt: [:new, :create]

  resource :user, only: [:edit, :update]
  resources :users, exept: [:edit, :update, :new, :create]

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
