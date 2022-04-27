class SpotsController < ApplicationController
  
  def new
    @spot = Spot.new
    @user = current_user
  end

  def create
    @spot = Spot.new(spot_params)
    @spot.user_id = current_user.id
    if @spot.lat == 0 || @spot.lng == 0 #緯度経度が0(場所選択忘れの可能性大)の場合はじく。
      redirect_to request.referer
    elsif @spot.save
      redirect_to spots_path
    else
      redirect_to request.referer
    end
  end

  def index
    @spots = Spot.all.page(params[:page]).per(6)
    @tags = Spot.tag_counts_on(:tags, limit: 10).order('count DESC')
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

  def taglist
    @tags = Spot.tag_counts_on(:tags).order('count DESC')
  end

  protected

  def spot_params
    params.require(:spot).permit(:user_id, :title, :body, :lat, :lng, :star, :image_id, :tag_list)
  end

end