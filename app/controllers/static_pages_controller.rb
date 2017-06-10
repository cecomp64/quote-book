class StaticPagesController < ApplicationController
  def home
    @random_quote = Quote.order('RANDOM()').first
  end
end
