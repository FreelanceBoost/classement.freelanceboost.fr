FreelanceboostRanking::Application.routes.draw do
  root 'rockstars#index'
  resources :rockstars
end
