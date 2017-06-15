class QuotesController < ApplicationController
  before_action :set_quote, only: [:show, :edit, :update, :destroy]

  respond_to :html, :json
  QUOTES_PER_PAGE = 20
  MPQ = MultiPartQuote

  def index
    @quotes = MPQ.joins(:quotes).includes(:quotes).order(created_at: :desc).uniq.page(params[:page]).per(QUOTES_PER_PAGE)
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

  def add_mpq
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
      mpqp[:quotes].each_with_index do |qp, index|
        quote = Quote.create(text: qp[:text], attribution: qp[:attribution], order: index)
        @quote.quotes << quote

        # Shut it down if any of them have errors
        if(quote.errors.any?)
          errors += quote.errors.full_messages
          @quote.quotes.each{|q| q.destroy}
          break
        end
      end
    end

    # Check that at least one quote was created
    if(@quote.quotes.size == 0)
      @quote.destroy
      @quote.quotes << Quote.new
      errors << 'Fill in at least one quote, you dope!'
    end

    # Update person quote counts
    if(errors.empty?)
      @quote.quotes.each do |q|
        q.attribution.update_attribute(:num_quotes, q.attribution.quotes.count) if(q.attribution)
      end
    else
      flash.now[:error] = errors.join('  ')
    end

    #respond_with(@quote)
    respond_to do |format|
      if(errors.size > 0)
        format.html {render :new}
      else
        format.html {render :show}
      end
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

    include PeopleHelper

    def set_quote
      @quote = MPQ.find(params[:id])
    end

    def quote_params
      p_dup = personify_params(params)
      quotes = []

      params[:quote].each do |quote|
        next if((quote[:text].nil? || quote[:text].empty?) && (quote[:attribution].nil? || quote[:attribution].empty?))
        q = personify_params(quote)
        quotes << q
      end

      return {quotes: quotes, author: p_dup[:author]}
    end
end
