module DiscourseGeekblePlugin
    class VideosController < ApplicationController
      def show
        topic = Topic.find(params[:id])
        render json: topic_to_video(topic)
      end
  
      private
      def topic_to_video(v)
        video = v.as_json
        first_post = v.posts.first.as_json
        if current_user
          liked_by_me = {liked_by_me: !!v.posts.first.post_actions.find_by(user_id: current_user.id, post_action_type_id: 2)}.as_json
          first_post = first_post.merge(liked_by_me)
        end
        video[:first_post] = first_post
        video[:user] = extract_user(c.user)
        video
      end
  
      def extract_user(user)
        { 
          id: user.id, username: user.username, name: user.name, admin: user.admin,
          avatar_template: user.avatar_template,
        }
      end
    end
  
  end