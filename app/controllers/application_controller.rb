class ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_search #ヘッダー各ページで検索を行う為、各動作前にメソッド実行。
  before_action :authenticate_user!, except: [:top]

  def set_search
    @q = { title_or_body_cont: params[:q] }
    # @q = (params[:q]) 必ずプランを変更する事
    @search = Spot.ransack(@q)
    @search_spots = @search.result.order(created_at: :desc).page(params[:page])
    @search_p = Plan.ransack(@q)
    @search_plans = @search_p.result.order(created_at: :desc).page(params[:page])
    @check = params[:q] #タグ情報の有無確認時に使用する為、@check内に情報を代入。
  end

  protected

  def after_sign_in_path_for(resource)
    spots_path
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_in, keys: [:name])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email])
  end

end
