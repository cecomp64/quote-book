class QuotesController < ApplicationController
  before_action :set_quote, only: [:show, :edit, :update, :destroy]

  respond_to :html, :json
  QUOTES_PER_PAGE = 20

  def index
    @quotes = Quote.all.page(params[:page]).per(QUOTES_PER_PAGE)
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
    qp = personify_params(quote_params)
    qp[:score] = 0
    @quote = Quote.new(qp)

    if(@quote.save)
      @quote.attribution.update_attribute(:num_quotes, @quote.attribution.quotes.count) if(@quote.attribution)
    end

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

  def search
    @query = params[:query]
    @results = {}
    results_per_category = 10

    @results[:attributed_to] = Quote.joins(:attribution).where('people.name ILIKE ?', "%#{@query}%")
    @results[:authored_by] = Quote.joins(:author).where('people.name ILIKE ?', "%#{@query}%")
    @results[:contains] = Quote.where('quotes.text ILIKE ?', "%#{@query}%")

    Quote::SEARCH_VECTORS.each do |vector|
      @results[vector] = @results[vector].page(params[vector]).per(results_per_category) if(@results[vector])
    end
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
