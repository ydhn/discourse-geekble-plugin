module DiscourseGeekblePlugin
  class TopicsController < ApplicationController
    def show
      topic = Topic.find(params[:id])
      posts = topic.posts.where("deleted_at IS NULL").order("created_at asc").offset(1)
      # 첫번째 original post를 제외함
      @posts = []
      posts.each do |p|
        post = p.as_json
        post[:like_count] = p.like_count
        post[:user] = p.user.as_json
        @posts.push(post)
      end
      render json: @posts
    end
  end
end