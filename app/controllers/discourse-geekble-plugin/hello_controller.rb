module DiscourseGeekblePlugin
  class HelloController < ApplicationController

    def index
      render_json_dump("Hello World")
    end

    def test
      render json: {message: "hi"}
    end

  end
end