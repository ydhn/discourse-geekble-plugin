class DiscourseGeekblePluginConstraint
  def matches?(request)
    SiteSetting.discourse_geekble_plugin_enabled
  end
end