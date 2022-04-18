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
    @spots = Spot.all.page(params[:page]).per(6)
    @tags = Spot.tag_counts_on(:tags).order('count DESC')
    if @tag = params[:tag]
      @spot = Spot.tagged_with(params[:tag])
    end
  end

  def show
    @spot = Spot.find(params[:id])
    @tags = @spot.tag_counts_on(:tags)
    @spot_comment = SpotComment.new
    
  end

  def edit
    @spot = Spot.find(params[:id])
    @tags = @spot.tag_counts_on(:tags)
  end
  
  def update
    @spot = Spot.find(params[:id])
    if @spot.update(spot_params)
      redirect_to spot_path(@spot)
    else
      render :edit
    end
  end
  
  def destroy
    @spot = Spot.find(params[:id])
    if @spot.destroy
      redirect_to spots_path
    else
      render :show
    end
  end
  
  def search
    @results = @q.result.includes(:user)
  end

  protected

  def spot_params
    params.require(:spot).permit(:user_id, :title, :body, :address, :lat, :lng, :star, :image_id, :tag_list)
  end
  
  
end
