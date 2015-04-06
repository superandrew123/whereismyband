class BandsController < ApplicationController
  before_action :login_required, only: [:create]
  autocomplete :band, :name

  def new
   @band = Band.new
  end

  def events
    # take a band ID from the li on the page
    # return that band's events
    @band = Band.find(params[:band_id])
    @events = @band.events.order(start_time: :asc)
    render :"events/events", :layout => false
  end

  # ENV["fb_access_token"]
  def create
    @user = current_user if current_user
    fb_slug = params[:band][:fb_slug].split("com/")[1].split(/[?\/]/)[0]
    begin
      fb_band = FbGraph::Page.fetch(fb_slug, :access_token => ENV["fb_access_token"])
      @band = Band.new(name: fb_band.name, fb_slug: fb_slug, search_name: fb_band.name.downcase)
      fb_band.events.each do |event|
        @band.events << Event.find_or_create_by(location: event.name, start_time: event.start_time)
      end
      @band.save
      @user.bands << @band
      @user.save
    rescue
      # Band not found
    end
    redirect_to root_path
  end

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
