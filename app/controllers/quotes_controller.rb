class QuotesController < ApplicationController
  before_action :set_quote, only: [:show, :edit, :update, :destroy]

  respond_to :html, :json
  QUOTES_PER_PAGE = 20
  MPQ = MultiPartQuote

  def index
    @quotes = MPQ.includes(:quotes).all.page(params[:page]).per(QUOTES_PER_PAGE)
    respond_with(@quotes)
  end

  def show
    respond_with(@quote)
  end

  def new
    @quote = MPQ.new
    @quote.quotes << Quote.new
    respond_with(@quote)
  end

  def edit
  end

  def create
    mpqp = quote_params
    errors = []

    @quote = MPQ.create(author: mpqp[:author], score: 0)

    # Don't process quotes if MPQ is not correct
    if(@quote.errors.any?)
      errors += @quote.errors.full_messages
    else
      # Process each quote
      mpqp[:quotes].each do |qp|
        quote = Quote.create(text: qp[:text], attribution: qp[:attribution])

        # Shut it down if any of them have errors
        if(quote.errors.any?)
          errors += quote.errors.full_messages
          @quote.quotes.each{|q| q.destroy}
          break
        else
          @quote.quotes << quote
        end
      end
    end

    # Update person quote counts
    if(errors.empty?)
      @quote.quotes.each do |q|
        q.attribution.update_attribute(:num_quotes, q.attribution.quotes.count) if(q.attribution)
      end
    else
      flash[:error] = errors.join('  ')
    end

    #respond_with(@quote)
    respond_to do |format|
      format.html {render :show}
    end
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

    @results[:attributed_to] = MPQ.joins(quotes: :attribution).where('people.name ILIKE ?', "%#{@query}%")
    @results[:authored_by] = MPQ.joins(:author).where('people.name ILIKE ?', "%#{@query}%")
    @results[:contains] = MPQ.joins(:quotes).where('quotes.text ILIKE ?', "%#{@query}%")

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
        next if !dup.key?(attribute)

        if(dup[attribute])
          dup[attribute] = dup[attribute].strip.empty? ? anonymous : Person.find_or_create_by(name: dup[attribute].strip)
        else
          dup[attribute] = anonymous
        end
      end

      return dup
    end

    def set_quote
      @quote = MPQ.find(params[:id])
    end

    def quote_params
      p_dup = personify_params(params)
      quotes = []

      params[:quote].each do |quote|
        q = personify_params(quote)
        quotes << q
      end

      return {quotes: quotes, author: p_dup[:author]}
    end
end
