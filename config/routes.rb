# frozen_string_literal: true

Rails.application.routes.draw do
  root "links#new"
  resources :links, only: %i[new create show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
