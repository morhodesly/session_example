class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def session_limit
    if current_user
      @logins = current_user.logins.order(updated_at: :desc)
      session_limit = SessionUser.find_by(user_id: current_user.id).session_limit
      if @logins.length() > session_limit
          found_login(cookies[:device_id]).destroy
          cookies.delete(:device_id)
          sign_out(current_user)
          respond_to do |format|
            format.html { redirect_to new_user_session_path, notice: 'You have been logged out due because another session was started' }
          end
      end
        puts "nothing happened!"
    end
  end

  def device_excited
    if !current_device_id
      sign_out(current_user)
      puts "signed out"
      flash[:notice] = "Successfully signed out."
      redirect_to root_path
    end
  end

  def current_device_id
    if current_user
      if cookies[:device_id].present?
        if login = current_user.logins.find_by(device_id: cookies[:device_id])
          login
        end
      end
    end
  end  


  private 
    def found_login(device_id)
      @logins.each do |login| 
        if (login.device_id == device_id)
          return login
        end
      end
    end
    
end
