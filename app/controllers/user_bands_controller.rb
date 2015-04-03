class UserBandsController < ApplicationController
  def create
    # search for a band and add it to a user
    # binding.pry
    @band = Band.find_by(band_params)
    @user = current_user
    if !@band
      # if band cannot be found, do not add to a user account
      render :layout => false
    elsif @user.bands.include?(@band)
      # if band can be found but already belongs to a user, do not add to user account
      flash.now[:notice] = "Artist already added"
      render :layout => false
    else
      # add band to user account
      @user.bands << @band
      @user.save
      render :layout => false
    end
  end

  def destroy
    # Delete the association of the band and the user,
    # not the user or the band
    @user_band = UserBand.find_by(band_id: params[:band_id])
    @user_band.destroy
    render nothing: :true, status: :ok
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