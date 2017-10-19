Rails.application.routes.draw do
  resources :group_keys, only: [:index,:create] do
    collection do
      put 'update_key'
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
    end
end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
