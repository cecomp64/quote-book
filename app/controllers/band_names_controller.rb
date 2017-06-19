class BandNamesController < ApplicationController
  before_action :set_band_name, only: [:show, :edit, :update, :destroy]

  respond_to :html

  include FilterHelper

  def index
    @filter = {}

    raw_filter = params[:filter] || {}
    raw_filter.map{|k, v| @filter[k.to_sym] = filter(raw_filter, k)}

    @band_names = BandName.all.order(created_at: :desc)
    @band_names = @band_names.joins(:person).where('people.name ILIKE ?', "#{@filter[:attribution]}") if(@filter[:attribution])
    @band_names = @band_names.where('band_names.name ILIKE ?', "%#{@filter[:band_name]}%") if(@filter[:band_name])

    @band_names = @band_names.page(params[:page]).per(20)
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
    if(@band_name.save)
      flash[:success] = 'You registered a rad new band name.'
      respond_with(@band_name)
    else
      flash[:error] = @band_name.errors.full_messages.join(' ')
      redirect_to new_band_name_path
    end
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
