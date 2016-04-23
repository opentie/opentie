Rails.application.routes.draw do
  namespace :api, format: 'json' do
    namespace :v1 do

      resource :account, only: [:new, :create, :edit, :update] do

        collection do
          post :email_confirm
        end

        resource :password, only: [:create, :update]
      end

      resources :sessions, only: [] do

        collection do

          post :sign_in
          post :sign_out
        end
      end

      resources :groups, only: [:show, :new, :create] do

        scope module: :groups do

          resources :sub_schemata, only: [:index, :show] do

            resource :request
          end

          resources :topics do

            scope module: :topics do

              resources :posts, only: [:new, :create, :edit, :update]
            end
          end
        end
      end

      resources :divisions, only: [:new, :create, :show] do

        member do

          post :invitation
        end

        scope module: :divisions do

          resources :group_schemata, except: :destroy do

            resources :groups, only: [:index, :show, :edit, :update] do

              resources :change_logs, only: :index
            end

            resources :sub_schemata
          end

          resources :group_topics, only: [:show] do

            scope module: :group_topics do

              resources :posts, only: [:new, :create, :edit, :update] do

                collection do

                  get :draft
                end
              end
            end
          end

          resources :topics

          resources :tags, except: [:show, :edit, :update]
        end
      end
    end
  end

  if Rails.env.development?
    require 'sidekiq/web'
    mount Sidekiq::Web => '/api/sidekiq'
    mount LetterOpenerWeb::Engine, at: "/api/letter_opener"
  end
end
