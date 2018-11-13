module DiscourseGeekblePlugin
  class CardsController < ApplicationController
    PAGE_SIZE = 10
    def top_index
      page = params[:page].to_i rescue 0
      stmt = card_topics(page, true).order("last_posted_at desc")
      render json: topics_to_json(stmt)
    end

    def recent_index
      page = params[:page].to_i rescue 0
      stmt = card_topics(page, false).order("last_posted_at desc")
      render json: topics_to_json(stmt)
    end

    def show
      topic = Topic.find(params[:id])
      render json: topic_to_card(topic)
    end

    private
    def card_topics(page, pin = nil)
      card_category_id = Category.find_by(slug: 'cards').id
      stmt = Topic.includes(:tags).includes(:user).includes(:posts)
      stmt = stmt.where(category_id: card_category_id)
      stmt = stmt.where("deleted_at IS NULL")
      stmt = stmt.where("last_posted_at IS NOT NULL")
      stmt = stmt.where("pinned_until >= ?", Date.today) if pin
      stmt = stmt.limit(PAGE_SIZE).offset(PAGE_SIZE * page)
    end

    def topics_to_json(stmt)
      @cards = []
      stmt.each do |c|
        card = topic_to_card(c)
        @cards.push card
      end
      @cards
    end

    def topic_to_card(c)
      card = c.as_json
      card[:tags] = c.tags.map(&:name).as_json
      remarkable_posts = c.posts.includes(:user).includes(:post_actions).where("post_number != 1").where("like_count > 0").order('like_count desc').limit(1)
      if remarkable_posts.size > 0
        rp = remarkable_posts.first
        remarkable_post_user = {user: extract_user(rp.user)}.as_json
        remarkable_post = rp.as_json.merge(remarkable_post_user)
        if current_user
          liked_by_me = {liked_by_me: !!rp.post_actions.find_by(user_id: current_user.id, post_action_type_id: 2)}.as_json
          remarkable_post = remarkable_post.merge(liked_by_me)
        end
        card[:remarkable_post] = remarkable_post
      end
      first_post = c.posts.first.as_json
      if current_user
        liked_by_me = {liked_by_me: !!c.posts.first.post_actions.find_by(user_id: current_user.id, post_action_type_id: 2)}.as_json
        first_post = first_post.merge(liked_by_me)
      end
      card[:first_post] = first_post
      card[:user] = extract_user(c.user)
      card
    end

    def extract_user(user)
      { 
        id: user.id, username: user.username, name: user.name, admin: user.admin,
        avatar_template: user.avatar_template,
      }
    end
  end

end