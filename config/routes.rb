Rails.application.routes.draw do

  devise_for :users
  root to: "homes#index"

  resources :users, only: [:index, :show, :edit, :unsubscribe, :withdrow, :create, :update] do
    get 'unsubscribe' => 'users#unsubscribe'
    patch 'withdrow' => 'users#withdrow'
  end

  resources :spots, only: [:new, :index, :show, :edit, :create, :update, :destroy] do
    resource :spot_comments, only: [:create, :destroy]
  end

  resources :plans, only: [:index, :show, :edit, :update, :destroy]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end
