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

  def create
    @cart_spots = CartSpot.where(user_id: current_user.id) #CartSpotに保存されているユーザーのスポットを呼び出す。
    @plan = Plan.new(plan_params)
    @plan.user_id = current_user.id #Planに該当userのidを保存
    if @plan.save
      @cart_spots.each do |cart_spot|
      spot_plan = SpotPlan.new
      spot_plan.plan_id = @plan.id #後にPlan情報を呼び出せるようPlan作成と同時にSpotPlan情報を作成し、都度plan_idで紐づけ。
      spot_plan.spot_id = cart_spot.spot.id #SpotPlan内にspot_idを保存(↑でplan_idと紐づけされ1つのプランとして呼び出せる)
      spot_plan.save
      end
      cart_spots = CartSpot.where(user_id: current_user.id) #プランをSpotPlan内plan_idで紐づけた為、ユーザーに紐づくCartSpot情報を削除。
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