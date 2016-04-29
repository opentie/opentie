Rails.application.routes.draw do
  namespace :api, format: 'json' do
    namespace :v1 do

      resource :account, except: [:destroy] do

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

      resources :groups, except: [:index, :destroy] do

        member do

          post :invite
        end

        scope module: :groups do

          resources :request_forms, only: [:index, :show] do

            resource :request, except: [:destroy, :edit]
          end

          resources :topics do

            scope module: :topics do

              resources :posts, except: [:show]
            end
          end
        end
      end

      resources :divisions, only: [:new, :create, :show] do

        member do

          post :invite
        end

        scope module: :divisions do

          resources :categories, param: :name, except: :destroy do

            scope module: :categories do

              resources :groups, only: [:index]

              resources :forms

              resources :topics
            end
          end

          resources :groups, only: [:show, :edit, :update] do

            scope module: :groups do

              resources :change_logs, only: :index
            end
          end

          resources :group_topics, only: [:show] do

            scope module: :group_topics do

              resources :posts, except: [:show]
            end
          end

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
