class CartSpotsController < ApplicationController


  def create
    @cart_spot = CartSpot.new(cart_spot_params)
    @cart_spot.user_id = current_user.id
    if current_user.cart_spots.find_by(spot_id: params[:cart_spot][:spot_id]).present?
      redirect_to request.referer
    elsif
      @cart_spot.save
      redirect_to new_plan_path
    else
      redirect_to request.referer
    end
  end

  def destroy
    @cart_spot = CartSpot.find(params[:id])
    @cart_spot.destroy
    redirect_to new_plan_path
  end

  def destroy_all
    current_user.cart_spots.destroy_all
    redirect_to spot_path(@cart_spot.spot_id)
  end

  private

  def cart_spot_params
    params.require(:cart_spot).permit(:spot_id, :user_id)
  end

end
