Rails.application.routes.draw do
  resources :webinars
  mount RedactorRails::Engine => '/redactor_rails'

  namespace :admin do
    root 'application#index'
  end

  # devise_for :users
  devise_for :users, controllers: { confirmations: 'confirmations' }

  resources :users do
    resources :skills, only: [:new, :create]
    post 'program_search', :on => :collection
    post 'desc_search', :on => :collection
    post 'name_search', :on => :collection
    post 'location_search', :on => :collection
  end

  root 'homes#index'

  resources :user_program_attendancies, only: [:new,
                                               :create,
                                               :destroy,
                                               :update,
                                               :edit,
                                               :index]

  resources :institutions, only: [:index, :show, :new] do
    collection do
      get :autocomplete
    end

    resources :programs do
      collection do
        get :autocomplete
      end

      resources :reviews, only: [:index,
                                 :create,
                                 :new,
                                 :destroy,
                                 :update,
                                 :edit,
                                 :show]

      resources :reviews, only: [:show] do
        member do
          put 'like', to: "reviews#upvote", defaults: { format: 'json' }
          put "dislike", to: "reviews#downvote", defaults: { format: 'json' }
        end
      end
    end
  end
end
