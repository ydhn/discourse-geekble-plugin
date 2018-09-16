require_dependency "discourse_geekble_plugin_constraint"

DiscourseGeekblePlugin::Engine.routes.draw do
  get "/hello" => "hello#index", constraints: DiscourseGeekblePluginConstraint.new
end