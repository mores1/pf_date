class PlansController < ApplicationController

  def new
    @cart_spots = CartSpot.where(user_id: current_user.id)
    @plan = Plan.new
  end

  def index
    @plans = Plan.all.page(params[:page]).per(9)
  end

  def show
    @plan = Plan.find(params[:id])
    @spot_plans = SpotPlan.where(plan_id: @plan.id)
  end

  def edit
    @plan = Plan.find(params[:id])
    @spot_plans = SpotPlan.where(plan_id: @plan.id)
  end

  def create
    @cart_spots = CartSpot.where(user_id: current_user.id)
    @plan = Plan.new(plan_params)
    @plan.user_id = current_user.id
    if @plan.save
      @cart_spots.each do |cart_spot|
      spot_plan = SpotPlan.new
      spot_plan.plan_id = @plan.id
      spot_plan.spot_id = cart_spot.spot.id
      spot_plan.save
      end
      cart_spots = CartSpot.where(user_id: current_user.id)
      cart_spots.destroy_all
      redirect_to plans_path
    else
      redirect_to request.referer
    end
  end

  def destroy
    @plan = Plan.find(params[:id])
    if @plan.destroy
      redirect_to plans_path
    else
      render :show
    end
  end


  private


  def plan_params
    params.require(:plan).permit(:user_id, :title, :body)
  end

end
