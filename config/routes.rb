Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: proc { [404, {}, ['']] }

  resources :users, only: [:show] do
    resources :tweets, only: [:index]
    resources :friends, only: [:index]
  end
end
