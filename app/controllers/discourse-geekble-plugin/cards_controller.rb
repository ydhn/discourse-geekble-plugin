module DiscourseGeekblePlugin
  class CardsController < ApplicationController
    PAGE_SIZE = 20
    def top_index
      page = params[:page].to_i rescue 0
      stmt = card_topics(page).order("score desc")
      render json: topics_to_json(stmt)
    end

    def recent_index
      page = params[:page].to_i rescue 0
      stmt = card_topics(page).order("last_posted_at desc")
      render json: topics_to_json(stmt)
    end

    private
    def card_topics(page)
      card_category = Category.find_by(slug: 'cards').id
      stmt = Topic.includes(:tags)
      stmt = stmt.where(category_id: card_category_id)
      stmt = stmt.where("deleted_at IS NULL")
      stmt = stmt.where("last_posted_at IS NOT NULL")
      stmt = stmt.limit(PAGE_SIZE).offset(PAGE_SIZE * page)
    end

    def topics_to_json(stmt)
      @cards = []
      stmt.each do |c|
        card = c.as_json
        card[:tags] = card.tags.map(&:name).as_json
        remarkable_posts = c.posts.where("like_count > 0").order('like_count desc').limit(1)
        card[:remarkable_post] = remarkable_posts.first.as_json if remarkable_posts.size
        card[:first_post] = c.posts.first.as_json
        @cards.push card
      end
      @cards
    end
  end

end