require_dependency "discourse_geekble_plugin_constraint"

constraints = DiscourseGeekblePluginConstraint.new
DiscourseGeekblePlugin::Engine.routes.draw do
  get "/hello" => "hello#index", constraints: constraints
  get "/test" => "hello#test", constraints: constraints, defaults: { format: :json }
end