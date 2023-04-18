
Rails.application.routes.draw do
  get 'admin' => 'admin#index'
  controller :sessions do
    get  'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end

  get 'sessions/create'
  get 'sessions/destroy'

  get 'store/categories', to: 'store#categories'
  get 'users/orders', to: 'users#show_orders'
  get 'users/line_items', to: 'users#show_line_items'
  resources :users
  resources :products do
    get :who_bought, on: :member
  end

  resources :support_requests, only: [ :index, :update ]
  scope '(:locale)' do
    resources :orders
    resources :line_items
    resources :carts
    root 'store#index', as: 'store_index', via: :all
  end
end

