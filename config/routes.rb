Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :groups,
        only: [:show, :edit, :new, :create, :update] do

        resources :sub_schemata,
          controller: 'groups/sub_shcemata',
          only: [:index, :show] do

          resource :request,
            controller: 'groups/sub_schemata/request',
            only: [:show, :new, :edit, :create, :update, :destroy]
        end

        resources :topics,
          controller: 'groups/topics',
          only: [:index, :show, :new, :edit, :create, :update] do

          resource :post,
            controller: 'groups/topics/post',
            only: [:new, :edit, :create, :update]
        end
      end

      resources :divisions,
        only: [:show, :edit, :new, :create, :update] do
        resources :group_schemata,
          controller: 'divisions/group_schemata',
          only: [:index, :show, :new, :edit, :create, :update] do

          resources :groups,
            controller: 'divisions/group_schemata/groups',
            only: [:index, :show, :edit, :update] do

            resources :change_logs,
              controller: 'divisions/group_schemata/groups/change_logs',
              only: [:index]
          end

          resources :sub_schemata,
            controller: 'divisions/group_schemata/sub_schemata',
            only: [:index, :show, :new, :edit, :create, :update, :destroy]
        end

        namespace :message,
          path: 'message' do
          resources :topics,
            only: [:index, :show, :new, :edit, :create, :update] do

            resource :post,
              controller: 'topics/post',
              only: [:new, :edit, :create, :udpate]
          end

          resources :labels,
            controller: 'labels',
            only: [:index, :new, :edit, :update, :create, :destroy]
        end
      end
    end
  end
end
