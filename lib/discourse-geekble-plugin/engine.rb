module DiscourseGeekblePlugin
  class Engine < ::Rails::Engine
    isolate_namespace DiscourseGeekblePlugin

    config.after_initialize do

      Discourse::Application.routes.append do
        mount ::DiscourseGeekblePlugin::Engine, at: "/geekble"
      end
    end

  end
end