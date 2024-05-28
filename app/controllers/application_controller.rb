class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:top, :about]
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  def create
    @user = user.find(params[:id])
    if @user.save
      flash[:notice] = "successfully　登録に成功しました"
      redirect_to user_path
    else
      flash[:notice] = "error　登録に失敗しました"
      render :top
    end
  end
    
  def after_sign_in_path_for(resource)
    user_path(current_user)
  end
  
  def after_sign_out_path_for(resource)
    root_path
  end
  
  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end
  
end
