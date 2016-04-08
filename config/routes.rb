Rails.application.routes.draw do
  namespace :api, format: 'json' do
    namespace :v1 do

      resource :account, only: [:new, :create, :edit, :update] do

        collection do
          post :email_confirm
        end

        resource :password, only: [:create, :update]
      end

      namespace :auth do
        resources :sessions, only: [] do

          collection do
            post :sign_in
            post :sign_out
          end
        end
      end

      resources :groups, only: [:show, :new, :create] do

        scope module: :groups do

          resources :sub_schemata, only: [:index, :show] do

            resource :request
          end

          namespace :message do
            resources :topics, only: [:index, :show, :new, :create] do

              resources :posts, only: :create
            end
          end
        end
      end

      resources :divisions, except: [:index, :destroy] do

        scope module: :divisions do

          resources :group_schemata, except: :destroy do

            resources :groups, only: [:index, :show, :edit, :update] do

              resources :change_logs, only: :index
            end

            resources :sub_schemata
          end

          namespace :message do
            resources :topics, except: [:destroy, :edit] do

              resources :posts, only: :create
            end

            resources :labels, except: :show
          end
        end
      end
    end
  end

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/api/letter_opener"
  end
end
