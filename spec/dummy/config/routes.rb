# frozen_string_literal: true

Rails.application.routes.draw do
  get '/monkey/id', to: 'monkey#show'
end
