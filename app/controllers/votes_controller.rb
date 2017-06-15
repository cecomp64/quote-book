class VotesController < ApplicationController
  before_action :set_vote, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @votes = Vote.all
    respond_with(@votes)
  end

  def show
    respond_with(@vote)
  end

  def new
    @vote = Vote.new
    respond_with(@vote)
  end

  def edit
  end

  def create
    @vote = Vote.new(vote_params)
    @vote.save
    respond_with(@vote)
  end

  def update
    @vote.update(vote_params)
    respond_with(@vote)
  end

  def destroy
    @vote.destroy
    respond_with(@vote)
  end

  # Non-CRUD functions
  def for
    @mpq = MultiPartQuote.where(id: params[:quote_id]).first
    @band_name = BandName.where(id: params[:band_name_id]).first
    user = User.find(params[:user_id])
    value = params[:value].to_i
    errors = []

    @vote = @band_name.nil? ? Vote.find_or_create_by(user: user, multi_part_quote: @mpq) : Vote.find_or_create_by(user: user, band_name: @band_name)

    # vote: 1, value: 1, increment: -1
    # vote: 1, value: -1, increment: -2
    # vote: -1, value: 1, increment: +2
    # vote: -1, value: -1. increment: +1
    # vote: 0, value: 1, increment: +1
    # vote: 0, value: -1, increment: -1

    sign = (@vote.value.nil? || @vote.value == 0) ? value : -@vote.value;
    magnitude = (@vote.value && @vote.value != 0 && @vote.value != value) ? 2 : 1;

    @vote.update_attribute(:value, (@vote.value == value) ? 0 : value)
    errors += @vote.errors.full_messages if(@vote.errors.any?)

    updated = @mpq ? @mpq : @band_name

    @score = updated.score + (sign * magnitude)
    updated.update_attribute(:score, @score)
  end

  private
    def set_vote
      @vote = Vote.find(params[:id])
    end

    def vote_params
      params.require(:vote).permit(:user_id, :quote_id, :value)
    end
end
