class BandsController < ApplicationController
  before_action :login_required, only: [:create]
  autocomplete :band, :name

  def new
    # root page
    @band = Band.new
    @user = current_user
    @events = current_user.events.order(start_time: :asc) if current_user
  end

  def events
    # take a band ID from the li on the page
    # return that band's events
    @band = Band.find(params[:band_id])
    @events = @band.events.order(start_time: :asc)
    render :"events/events", :layout => false
  end

  def create
    # Make a new band
    @band = Band.new
  end

  # Redacted and moved to user_bands_controller
  # def show
  #   # search for a band and add it to a user
  #   @band = Band.find_by(band_params)
  #   @user = current_user
  #   if !@band
  #     # if band cannot be found, do not add to a user account
  #     render :layout => false
  #   elsif @user.bands.include?(@band)
  #     # if band can be found but already belongs to a user, do not add to user account
  #     flash.now[:notice] = "Artist already added"
  #     render :layout => false
  #   else
  #     # add band to user account
  #     @user.bands << @band
  #     @user.save
  #     render :layout => false
  #   end
  # end

  def autocomplete_name
    @bands = Band.order(:name).where('name LIKE ?', "#{params[:term].titleize}%").limit(10)
    respond_to do |format|
      format.json { render json: @bands.map(&:name) }
    end
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
