Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  scope '/api' do
    scope '/v1' do
      use_doorkeeper
      devise_for :users, controllers: {
        registrations: 'api/v1/users/registrations',
      }
    end
  end

  scope module: :api, path: 'api' do
    scope module: :v1, path: 'v1' do
      resources :questions, only: [:index]
    end
  end
end
