class UsersController < ApplicationController
  def index
    @users = User.where.not(name: "admin").where.not(name: "guestuser").page(params[:page])
  end

  def show
    @user = User.find(params[:id])
    @spots = Spot.where(user_id: @user.id)
    @plans = Plan.where(user_id: @user.id)
  end

  def edit
    @user = User.find(params[:id])
  end

  def unsubscribe
    @user = current_user

  end

  def withdrow
    @user = current_user
    @user.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email,  :is_deleted, :admin, :image_id)
  end

end