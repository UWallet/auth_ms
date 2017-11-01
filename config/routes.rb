Rails.application.routes.draw do
  wash_out :wsusers
  resources :group_keys, only: [:index,:create] do
    collection do
      put 'update_key'
      get 'get_group_key'
    end
  end
  resources :users, only: [:create, :update, :show] do
    collection do
      post 'confirm'
      post 'login'
      get 'get_user'
      get 'search_user'
      put 'update_money'
      get 'get_money'
      get 'get_identification'
      post 'verify_pass'
      get 'logout'
    end
end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
