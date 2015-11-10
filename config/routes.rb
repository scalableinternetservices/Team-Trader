Rails.application.routes.draw do

  get 'random_gt_query/volume'

  get 'random_gt_query/gts'

  get 'google_trends_prediction/index'

  get 'google_trends_prediction/show'

  devise_for :users, controllers:{ sessions: 'users/sessions', passwords: 'users/passwords', registrations: 'users/registrations' }
  
  root to: 'pages#home'

  get 'company_list/getHints'


  get 'volume_chart/index'
  get 'volume_chart/show'


  get 'google_trends_strategy/index'
  get 'google_trends_strategy/show'
  get 'quotes/getHistoricalData'

  get 'google_trends_strategy/get_stock_search_history'
  get 'google_trends_strategy/get_term_search_history'

  resources :investments

  #Deprecated
  get 'charts/PLChart'
  get "/pages/:page" => "pages#show"

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
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
