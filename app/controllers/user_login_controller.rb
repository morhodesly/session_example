class UserLoginController < Devise::SessionsController
  layout "user_login"
  
  def create
    current_user.remember_me!
    user = current_user
    user.remember_me = true
    if user
      if cookies[:device_id].present?
        if login = user.logins.find_by(device_id: cookies[:device_id])
          login.update!(
            ip_address: request.ip,
            user_agent: request.user_agent,
            updated_at: Time.now
          )
        end
      else
        device_id = SecureRandom.uuid
        cookies.permanent[:device_id] = device_id

        current_user.logins.create!(
          ip_address: request.remote_ip,
          user_agent: request.user_agent,
          device_id: device_id
        )
      end
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
    redirect_to root_path
    
  end
end
