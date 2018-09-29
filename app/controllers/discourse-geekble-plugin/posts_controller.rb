module DiscourseGeekblePlugin
  class PostsController < ApplicationController
    def reply
      pr = PostReply.create(post_id: params[:id], reply_id: params[:post_id])
      render json: pr, status: 201
    end
  end
end