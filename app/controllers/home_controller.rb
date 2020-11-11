class HomeController < ApplicationController
  before_filter :authenticate_user!
  before_filter :device_excited
  before_filter :session_limit
  
  def index
    @logins = current_user.logins.order(updated_at: :desc)
  end
end
