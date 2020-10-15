Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'welcome#index'

  get '/shelters', to: 'shelters#index'
  get '/shelters/new', to: 'shelters#new'
  get '/shelters/:id', to: 'shelters#show'
  post '/shelters', to: 'shelters#create'
  get '/shelters/:id/edit', to: 'shelters#edit'
  patch '/shelters/:id', to: 'shelters#update'
  delete '/shelters/:id', to: 'shelters#destroy'
  get '/shelters/:id/pets', to: 'shelters#pets'
  get '/shelters/:id/pets/new', to: 'shelters#new_pet'
  post '/shelters/:id/pets', to: 'shelters#create_pet'

  get '/pets', to: 'pets#index'
  get '/pets/:id', to: 'pets#show'
  get '/pets/:id/edit', to: 'pets#edit'
  patch '/pets/:id', to: 'pets#update'
  delete '/pets/:id', to: 'pets#destroy'

  get '/users/new', to: 'users#new'
  get '/users/:id', to: 'users#show'
  post '/users', to: 'users#create'

  get '/shelters/:id/reviews/new', to: 'shelter_reviews#new'
  post '/shelters/:id', to: 'shelter_reviews#create'
  get '/shelters/:id/:review_id/edit', to: 'shelter_reviews#edit'
  patch '/shelters/:id/:review_id', to: 'shelter_reviews#update'
  delete '/shelters/:id/:review_id', to: 'shelter_reviews#destroy'

end
