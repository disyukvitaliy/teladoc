Rails.application.routes.draw do
  namespace :api do
    resources :appointments, only: [:index, :update]

    resources :patient_appointments, only: [:index, :create, :destroy]

    resources :patients, only: [:show] do
      resources :appointments, only: [:index]
    end

    resources :specialists, shallow: true, only: [:index] do
      resources :schedules, only: [:index, :create, :update, :destroy]
    end
  end
end
