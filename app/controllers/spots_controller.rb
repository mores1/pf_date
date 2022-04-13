class SpotsController < ApplicationController
  def new
    @spot = Spot.new
    @user = current_user
  end
  
  def create
    @spot = Spot.new(spot_params)
    @spot.user_id = current_user.id
    if @spot.save
      redirect_to spots_path
    else
      redirect_to user_path(@user)
    end
  end

  def index
    @spots = Spot.all
  end

  def show
    @spot = Spot.find(params[:id])
  end

  def edit
  end
  
  protected
  
  def spot_params
    params.require(:spot).permit(:user_id, :title, :body, :address, :latitude, :longitude, :star)
  end
  
end
