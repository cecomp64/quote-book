class QuotesController < ApplicationController
  before_action :set_quote, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @quotes = Quote.all
    respond_with(@quotes)
  end

  def show
    respond_with(@quote)
  end

  def new
    @quote = Quote.new
    respond_with(@quote)
  end

  def edit
  end

  def create
    @quote = Quote.new(quote_params)
    @quote.save
    respond_with(@quote)
  end

  def update
    @quote.update(quote_params)
    respond_with(@quote)
  end

  def destroy
    @quote.destroy
    respond_with(@quote)
  end

  private

    def anonymous
      Person.find_or_create_by(name: 'Anonymous')
    end

    # Convert a text person to a Person object
    def personify_params(p)
      return p if(!p.is_a?(Hash))
      dup = p.dup

      [:attribution, :author].each do |attribute|
        if(dup[attribute])
          dup[attribute] = dup[attribute].strip.empty? ? anonymous : Person.find_or_create_by(name: dup[attribute].strip)
        else
          dup[attribute] = anonymous
        end
      end

      return dup
    end

    def set_quote
      @quote = Quote.find(params[:id])
    end

    def quote_params
      params.require(:quote).permit(:text, :attribution, :author)
    end
end
