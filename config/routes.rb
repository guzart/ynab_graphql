Rails.application.routes.draw do
  post "/graphql", to: "graphql#execute"
  root 'root#index'
end
