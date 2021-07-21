Rails.application.routes.draw do
  namespace :api, defaults: { format: 'json' } do

    resources :laboratories, except: [:destroy] do
      put 'disable'
    end

    resources :exams, except: [:destroy] do
      put 'disable'
    end
  end
end
