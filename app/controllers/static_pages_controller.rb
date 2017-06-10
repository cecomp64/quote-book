class StaticPagesController < ApplicationController
  def home
    @random_quote = Quote.order('RANDOM()').first
    @top_quotes = Quote.order(score: :desc).limit(5).page(1).per(20)
    @recent_quotes = Quote.order(created_at: :desc).limit(5).page(1).per(20)
    @top_quoters = Person.order(num_quotes: :desc).limit(5).page(1).per(20)

    @quotes = Quote.order(created_at: :desc).page(params[:page]).per(20)
  end
end
