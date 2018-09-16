module DiscourseGeekblePlugin
  class TopicsController < ApplicationController
    def show
      topic = Topic.find(params[:id])
      @posts = topic.posts.where("deleted_at IS NULL")
      render json: @posts
    end
  end
end