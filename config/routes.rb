require_dependency "discourse_geekble_plugin_constraint"

constraints = DiscourseGeekblePluginConstraint.new
DiscourseGeekblePlugin::Engine.routes.draw do
  get "/hello" => "hello#index", constraints: constraints
  get "/cards" => "cards#index", constraints: constraints, defaults: { format: :json }
  get "/topics/:id" => "topics#show", constraints: constraints, defaults: { format: :json }
end