require_dependency "discourse_geekble_plugin_constraint"

constraints = DiscourseGeekblePluginConstraint.new
DiscourseGeekblePlugin::Engine.routes.draw do
  get "/cards" => "cards#test", constraints: constraints, defaults: { format: :json }
end