module DiscourseGeekblePlugin
  class TopicsController < ApplicationController
    def show
      topic = Topic.find(params[:id])
      posts = topic.posts.includes(:user).where("deleted_at IS NULL").order("created_at asc").offset(1)
      # 첫번째 original post를 제외함
      @posts = []
      posts.each do |p|
        post = p.as_json
        post[:like_count] = p.like_count
        post[:user] = extract_user(p.user)
        @posts.push(post)
      end
      render json: @posts
    end

    private
    def extract_user(user)
      { 
        id: user.id, username: user.username, name: user.name, admin: user.admin,
        avatar_template: user.avatar_template,
      }
    end
  end
end