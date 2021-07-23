Rails.application.routes.draw do
  namespace :api, defaults: { format: 'json' } do
    resources :laboratories, except: [:destroy] do
      put 'disable'
      collection do
        post 'batch_create'
        put 'batch_update'
        put 'batch_disable'
        get 'search_by_exam'
      end
    end

    resources :exams, except: [:destroy] do
      put 'disable'
      collection do
        post 'batch_create'
        put 'batch_update'
        put 'batch_disable'
      end
    end

    post 'exams_laboratories/associate' => 'exams_laboratories#associate'
    post 'exams_laboratories/dissociate' => 'exams_laboratories#dissociate'
  end
end
