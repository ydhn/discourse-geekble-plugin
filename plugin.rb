# name: discourse-geekble-plugin
# about: Discourse extension for Geekble Website
# version: 0.1
# author: Yundo Han
# license: UNLICENSED
# url: https://github.com/ydhn/discourse-geekble-plugin
enabled_site_setting :discourse_geekble_plugin_enabled

gem 'jbuilder', github: 'rails/jbuilder', branch: '2.0.x-stable'
gem 'kaminari', github: 'kaminari/kaminari', branch: '1-0-stable'
register_asset 'stylesheets/discourse-geekble-plugin.scss'

load File.expand_path('../lib/discourse-geekble-plugin/engine.rb', __FILE__)