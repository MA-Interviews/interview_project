Rails.application.routes.draw do
  get 'the_logz', to: 'query_logs#index', as: :the_logz
  get 'populations', to: 'populations#index'
  get 'populations/by_year', to: 'populations#show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
