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
      flash.now[:notice] = "Artist already added"
      render :new      
    else
      # flash.now[:notice] = "TEST"
      @user.bands << @band
      @user.save
      render :layout => false
    end
  end


  private

    def sanitize_params
       params.require(:band).permit(:name)
    end
    
    def band_params
      band_hash = Hash.new
      sanitize_params.each do |k, v| 
        band_hash[k] = v.downcase 
      end
      band_hash
      # binding.pry
    end
end
