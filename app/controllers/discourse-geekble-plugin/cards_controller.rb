module DiscourseGeekblePlugin
  class CardsController < ApplicationController
    def index
      card_category = Category.find_by(slug: 'cards')
      params[:page] = params[:page].to_i rescue 1
      @cards = card_category.topics.page(params[:page]).per(20)
      render json: @cards
    end
  end
end