class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :show_curent_session

  def check_session_limit!
    if cookies[:device_id].present?
      if !current_device_id(cookies[:device_id])
        cookies.delete(:device_id)
        sign_out(current_user)
        respond_to do |format|
          format.html { redirect_to new_user_session_path, notice: 'you have been logged out due because another session was started' }
        end
      end
    else 
      sign_out(current_user)
      respond_to do |format|
        format.html { redirect_to new_user_session_path }
      end
    end

    return false
  end
  
  private 
    def current_device_id(device_id)
      if @login = current_user.logins.find_by(device_id: device_id)
        @login
      end 
    end  
    
    def show_curent_session
      if session[:device_id]
       puts "device id : #{session[:device_id]}"
      else
        puts "Nothing"
      end
    end
end
