class BandNamesController < ApplicationController
  before_action :set_band_name, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @band_names = BandName.order(created_at: :desc).page(params[:page]).per(20)
    respond_with(@band_names)
  end

  def show
    respond_with(@band_name)
  end

  def new
    @band_name = BandName.new
    respond_with(@band_name)
  end

  def edit
  end

  def create
    bp = personify_params(band_name_params)

    @band_name = BandName.new(bp)
    @band_name.save
    respond_with(@band_name)
  end

  def update
    @band_name.update(band_name_params)
    respond_with(@band_name)
  end

  def destroy
    @band_name.destroy
    respond_with(@band_name)
  end

  private
    include PeopleHelper

    def set_band_name
      @band_name = BandName.find(params[:id])
    end

    def band_name_params
      params.require(:band_name).permit(:name, :person)
    end
end
