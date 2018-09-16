module DiscourseGeekblePlugin
  class CardsController < ApplicationController
    PAGE_SIZE = 20

    def index
      card_category = Category.find_by(slug: 'cards')
      page = params[:page].to_i rescue 1
      stmt = card_category.topics.where("deleted_at IS NULL")
      stmt = stmt.order("last_posted_at desc")
      stmt = stmt.limit(PAGE_SIZE).offset(PAGE_SIZE * (page-1))
      @cards = []
      stmt.each do |c|
        card = c.as_json
        remarkable_posts = c.posts.where("like_count > 0").order('like_count desc').limit(1)
        card[:remarkable_post] = remarkable_posts.first.as_json if remarkable_posts.size
        card[:first_post] = c.posts.first.as_json
        @cards.push card
      end
      render json: @cards
    end
  end
end