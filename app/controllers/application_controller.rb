class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_search
  
  def set_search
    # @search = Spot.ransack(params[:q])
    # @search_spots = @search.result.includes(:title, :body).page(params[:page])
    
    @q = { title_or_body_cont: params[:q] }
    @search = Spot.ransack(@q)
    @search_spots = @search.result.order(created_at: :desc).page(params[:page])
    @check = params[:q]
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
