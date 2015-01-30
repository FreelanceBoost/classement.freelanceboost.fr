FreelanceboostRanking::Application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root 'rockstars#index'
  get 'rockstars' => 'rockstars#index'
  resources 'rockstars'
end
