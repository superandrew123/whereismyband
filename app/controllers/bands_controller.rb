class BandsController < ApplicationController
  before_action :login_required, only: [:create]
  autocomplete :band, :name

  def new
    @band = Band.new
    @user = current_user
    @events = current_user.events.order(start_time: :desc)
  end

  def events
    # take a band ID from the li on the page
    # return that band's events
    @band = Band.find(params[:band_id])
    @events = @band.events
    render :"events/events", :layout => false
    binding.pry
  end

  def create
    @band = Band.find_by(band_params)
    @user = current_user
    if !@band
      # flash.now[:notice] = "Could not find that artist"
      render :layout => false
    elsif @user.bands.include?(@band)
      flash.now[:notice] = "Artist already added"
      render :layout => false
    else
      # flash.now[:notice] = "TEST"
      @user.bands << @band
      @user.save
      render :layout => false
    end
  end

  def autocomplete_name
    @bands = Band.order(:name).where('name LIKE ?', "#{params[:term]}%").limit(10)
    respond_to do |format|
      format.json { render json: @bands.map(&:name) }
    end
  end

  def destroy
    @band = Band.find(params[:id])
    @Band.destroy
  end


  private
    def sanitize_params
       params.require(:band).permit(:name)
    end

    def band_params
      band_hash = Hash.new
      sanitize_params.each do |k, v|
        if k == "name"
          band_hash[:search_name] = v.downcase.strip
        end
      end
      band_hash
    end
end
