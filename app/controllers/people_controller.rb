class PeopleController < ApplicationController
  before_action :set_person, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @people = Person.all.page(params[:page]).per(10)
    respond_with(@people)
  end

  def show
    @random_quote = @person.quotes.order('RANDOM()').first
    @my_quotes = @person.quotes.uniq.page(params[:my_quotes]).per(5)
    @their_quotes = @person.entries.page(params[:their_quotes]).per(5)
    @bands = @person.band_names.page(params[:bands]).per(5)
    respond_with(@person)
  end

  def new
    @person = Person.new
    respond_with(@person)
  end

  def edit
  end

  def create
    @person = Person.new(person_params)
    @person.save
    respond_with(@person)
  end

  def update
    @person.update(person_params)
    respond_with(@person)
  end

  def destroy
    @person.destroy
    respond_with(@person)
  end

  private
    def set_person
      @person = Person.find(params[:id])
    end

    def person_params
      params.require(:person).permit(:name)
    end
end
