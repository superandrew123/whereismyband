class BandsController < ApplicationController

  before_action :login_required, only: [:create]

  def new
    @band = Band.new
    @user = current_user
  end


  def create
    binding.pry
    @band = Band.find_by(band_params)
    @user = current_user
    if !@band
      # flash.now[:notice] = "Could not find that artist"
      render :layout => false
    elsif @user.bands.include?(@band)
      flash.now[:notice] = "Artist already added TEST"
      render :layout => false
    else
      # flash.now[:notice] = "TEST"
      @user.bands << @band
      @user.save
      render :layout => false
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
