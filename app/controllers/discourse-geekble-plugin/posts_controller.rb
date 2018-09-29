module DiscourseGeekblePlugin
  class PostsController < ApplicationController
    before_action :requires_valid_user
    
    def reply
      reply_post = Post.find(params[:reply_id])
      raise Discourse::NotFound if current_user.id != reply_post.user_id
      pr = PostReply.create(post_id: params[:post_id], reply_id: params[:reply_id])
      render json: pr, status: 201
    end

    private 
    def requires_valid_user
      raise Discourse::NotFound if current_user.nil?
    end
  end
end