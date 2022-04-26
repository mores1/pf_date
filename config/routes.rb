Rails.application.routes.draw do

  root :to => "homes#top"
  devise_for :users
  get 'taglist' => 'spots#taglist'


  resources :users, only: [:index, :show, :edit, :create, :update] do
    get 'unsubscribe' => 'users#unsubscribe'
    patch 'withdrow' => 'users#withdrow'
  end
  
  
  
  resources :cart_spots, only: [:update, :destroy, :create] do
    collection do
        delete 'destroy_all'
      end
  end

  resources :spots do
    
    resources :spot_comments, only: [:create, :destroy]
    get 'search' => 'spots#search'
  end

  resources :plans, only: [:new, :index, :show, :destroy, :create]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end

end
