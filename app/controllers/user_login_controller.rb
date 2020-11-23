class UserLoginController < Devise::SessionsController
  layout "user_login"
  
  def create
    user = current_user
    if user
      device_id = Devise.friendly_token
      cookies[:device_id] = device_id

      logins = current_user.logins
      session_limit = SessionUser.find_by(user_id: current_user.id).session_limit
      if logins.length() >= session_limit
        logins.destroy_all
      end
      
      current_user.logins.create!(
        ip_address: request.remote_ip,
        user_agent: request.user_agent,
        device_id: cookies[:device_id]
      )
      
      redirect_to root_path
    else
      redirect_to new_user_session_path
    end
  end

  def destroy
    login = current_user.logins.find_by(device_id: cookies[:device_id])
    if login
      login.destroy
      cookies.delete(:device_id)
    end

    sign_out(current_user)
    flash[:notice] = "Successfully signed out."
    redirect_to new_user_session_path
    
  end

 
   
end
