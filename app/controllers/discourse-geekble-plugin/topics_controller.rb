module DiscourseGeekblePlugin
  class TopicsController < ApplicationController
    def show
      topic = Topic.find(params[:id])
      posts = topic.posts.where("deleted_at IS NULL")
      @posts = []
      posts.each do |p|
        post = p.as_json
        post[:like_count] = p.like_count
        @posts.push(post)
      end
      render json: @posts
    end
  end
end