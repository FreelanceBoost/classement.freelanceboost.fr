FreelanceboostRanking::Application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root 'rockstars#index'
  get 'rockstars' => 'rockstars#index'
  get 'auth/linkedin/callback' => 'linkedin#create'
  get 'auth/linkedin/callback/cancel' => 'linkedin#index'
  resources 'rockstars'
  resources 'dribbblers'
  resources 'githubers'
  resources 'linkedin'
end
