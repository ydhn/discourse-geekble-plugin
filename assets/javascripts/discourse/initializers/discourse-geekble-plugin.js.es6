import { withPluginApi } from "discourse/lib/plugin-api";

function initialize_discourse_geekble_plugin(api) {

}

export default {
  name: "discourse-geekble-plugin",

  initialize() {
    withPluginApi("0.8.24", initialize_discourse_geekble_plugin);
  }
};