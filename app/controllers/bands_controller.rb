class BandsController < ApplicationController
  before_action :login_required, only: [:create]
  autocomplete :band, :name

  def new
   @band = Band.new
  end

  def events
    @band = Band.find(params[:band_id])
    @events = @band.events.order(start_time: :asc)
    render :"events/events", :layout => false
  end

  def create
    @user = current_user if current_user
    begin
      fb_band = FbGraph::Page.fetch(fb_slug, :access_token => ENV["fb_access_token"])
      band_name = fb_slug.gsub("_"," ").gsub("-"," ")
      @band = Band.new(name: band_name, fb_slug: fb_slug, search_name: band_name.downcase)
      fb_band.events.each do |event|
        @band.events << Event.find_or_create_by(location: event.name, start_time: event.start_time, link: fb_params[:fb_slug])
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
    def fb_params
       params.require(:band).permit(:fb_slug)
    end

    def fb_slug
      slug = fb_params[:fb_slug].split("com/")[1]
      if slug[0..5] == "pages/"
        slug = slug[6..-1]
      end
      slug = slug.split(/[?\/]/)[0]
    end
end
