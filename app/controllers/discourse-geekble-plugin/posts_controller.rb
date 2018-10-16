module DiscourseGeekblePlugin
  class PostsController < ApplicationController
    before_action :requires_valid_user
    
    def reply
      reply_post = Post.find(params[:reply_id])
      raise Discourse::NotFound if current_user.id != reply_post.user_id
      pr = PostReply.create(post_id: params[:post_id], reply_id: params[:reply_id])
      render json: pr, status: 201
    end

    def unlike
      @post_action_type_id = params[:post_action_type_id].to_i
      post_action = current_user.post_actions.find_by(post_id: params[:id].to_i, post_action_type_id: @post_action_type_id, deleted_at: nil)
      raise Discourse::NotFound if post_action.blank?
      post_action.trash!
      post_action.save
    end

    private 
    def requires_valid_user
      raise Discourse::NotFound if current_user.nil?
    end
  end
end