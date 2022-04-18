Rails.application.routes.draw do

  devise_for :users
  root to: "homes#index"

  resources :users, only: [:index, :show, :edit, :create, :update] do
    get 'unsubscribe' => 'users#unsubscribe'
    patch 'withdrow' => 'users#withdrow'
  end

  resources :spots do
    resources :spot_comments, only: [:create, :destroy]
    get 'search' => 'spots#search'
  end

  resources :plans, only: [:index, :show, :edit, :update, :destroy]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end
