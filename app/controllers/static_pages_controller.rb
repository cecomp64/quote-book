class StaticPagesController < ApplicationController
  MPQ = MultiPartQuote

  def home
    @random_quote = MPQ.order('RANDOM()').first
    @top_quotes = MPQ.joins(:quotes).order(score: :desc).limit(5).page(1).per(20)
    @recent_quotes = MPQ.joins(:quotes).order(created_at: :desc).limit(5).page(1).per(20)
    @top_quoters = Person.order(num_quotes: :desc).limit(5).page(1).per(20)

    @quotes = MPQ.joins(:quotes).includes(:quotes).order(created_at: :desc).page(params[:page]).per(20)
  end
end
