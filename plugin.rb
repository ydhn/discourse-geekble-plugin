# name: discourse-geekble-plugin
# about: Discourse extension for Geekble Website
# version: 0.1
# author: Yundo Han
# license: UNLICENSED
# url: https://github.com/ydhn/discourse-geekble-plugin
enabled_site_setting :discourse_geekble_plugin_enabled

register_asset 'stylesheets/discourse-geekble-plugin.scss'

load File.expand_path('../lib/discourse-geekble-plugin/engine.rb', __FILE__)