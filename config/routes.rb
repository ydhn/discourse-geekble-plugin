require_dependency "discourse_geekble_plugin_constraint"

constraints = DiscourseGeekblePluginConstraint.new
DiscourseGeekblePlugin::Engine.routes.draw do
  get "/hello" => "hello#index", constraints: constraints
  get "/cards" => "cards#recent_index", constraints: constraints, defaults: { format: :json }
  get "/cards/top" => "cards#top_index", constraints: constraints, defaults: { format: :json }
  get "/cards/:id" => "cards#show", constraints: constraints, defaults: { format: :json }
  get "/topics/:id" => "topics#show", constraints: constraints, defaults: { format: :json }
  post "/reply/:post_id" => "posts#reply", constraints: constraints, defaults: { format: :json }
  delete "/posts/:id/like" => "posts#unlike", constraints: constraints, defaults: { format: :json }
end