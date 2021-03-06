class StaticPagesController < ApplicationController
  MPQ = MultiPartQuote

  def home
    sample_num = 5

    @random_quote = MPQ.order('RANDOM()').first
    @band = BandName.order('RANDOM()').first
    @top_quotes = MPQ.joins(:quotes).order(score: :desc).limit(sample_num).uniq
    @recent_quotes = MPQ.joins(:quotes).order(created_at: :desc).limit(sample_num).uniq
    @top_quoters = Person.where.not(num_quotes: nil).order(num_quotes: :desc).limit(sample_num)

  end
end
