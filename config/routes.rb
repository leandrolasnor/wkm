# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resource :employee, only: [] do
    post :hire
    patch :promotion
    delete :fire
  end

  resource :employees, only: [] do
    get :list
  end

  resource :vacation, only: [] do
    post :schedule
  end

  root to: 'api#health', via: :all
  match '*path' => 'api#not_found', via: :all
end
