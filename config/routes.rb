Rails.application.routes.draw do
  resources :campaigns do
    collection do
      post :import
      get :criteria_keywords
    end

    resources :ad_groups, only: [:index, :show] do
      resources :keywords, only: [:index, :show]
    end
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "campaigns#index"
end