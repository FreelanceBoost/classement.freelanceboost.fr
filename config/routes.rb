FreelanceboostRanking::Application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  
  if ENV['new_home'] == '1'
    root 'ranking#index'
  else
    root 'rockstars#index'
  end

  get 'twitter' => 'rockstars#index'
  get 'all' => 'ranking#index'
  get 'auth/linkedin/callback' => 'linkedin#create'
  get 'auth/linkedin/callback/cancel' => 'linkedin#index'
  resources 'rockstars'
  resources 'dribbblers'
  resources 'githubers'
  resources 'linkedin'
  resources 'ranking'
end
