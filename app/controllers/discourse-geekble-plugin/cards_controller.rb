module DiscourseGeekblePlugin
  class CardsController < ApplicationController
    PAGE_SIZE = 20

    def index
      card_category = Category.find_by(slug: 'cards')
      page = params[:page].to_i-1 rescue 0
      @cards = card_category.topics.limit(PAGE_SIZE).offset(PAGE_SIZE * page).to_a
      render json: @cards
    end
  end
end