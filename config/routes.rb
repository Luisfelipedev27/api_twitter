Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users, only: [:show, :create] do
        post 'create_post', on: :member
      end

      resources :posts, only: [:index, :create] do
        member do
          post :repost
        end
      end
    end
  end
end
