module DiscourseGeekblePlugin
  class TopicsController < ApplicationController
    def show
      topic = Topic.find(params[:id])
      posts = topic.posts.includes(:user).includes(:post_actions).where("deleted_at IS NULL").order("created_at asc").offset(1)
      # 첫번째 original post를 제외함
      @posts = []
      posts.reverse.each do |p|
        post = p.as_json
        post[:like_count] = p.like_count
        post[:user] = extract_user(p.user)
        if current_user
          post[:liked_by_me] = p.post_actions.find_by(user_id: current_user.id, post_action_type_id: 2)
        end
        @posts.push(post)
      end
      render json: { posts: @posts }
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