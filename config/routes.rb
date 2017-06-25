Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
  root to: 'teams#index'
  resources :teams, only: [:create, :destroy]
  get '/:slug', to: 'teams#show'
  get '/invite_confirm/:team_id/user/:user_id', to: 'team_users#invite_confirm', as: :invite_confirm
  resources :channels, only: [:show, :create, :destroy]
  resources :talks, only: [:show]
  resources :team_users, only: [:create, :destroy] do
    delete 'leave_team', on: :member
    post 'send_invite_team_mail', on: :member
  end
  devise_for :users, :controllers => { registrations: 'registrations' }
end
