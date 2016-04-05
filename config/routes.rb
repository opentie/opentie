Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :groups do
        resources :sub_schemata do
          resource :request
        end

        resources :topics do
          resources :posts
        end
      end

      resources :divisions do
        resources :group_schemata do
          resources :groups do
            resources :change_logs, only: :index
          end

          resources :sub_schemata
        end

        namespace :message do
          resources :topics do
            resources :posts
          end

          resources :labels
        end
      end
    end
  end
end
