class BandsController < ApplicationController

  def new
    @band = Band.new
    @user = current_user
  end


  def create
    @band = Band.find_by(band_params)
    @user = current_user
    @user.bands << @band
    @user.save
    redirect_to root_path
  end


  private
    def band_params
      params.require(:band).permit(:name)
    end
end
