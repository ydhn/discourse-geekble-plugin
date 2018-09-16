module DiscourseGeekblePlugin
  class HelloController < ApplicationController

    def index
      render_json_dump("Hello World")
    end

    def test
      render { "message": "hi" }, json: true
    end

  end
end