class HomeController < ApplicationController
  before_filter :authenticate_user!
  before_filter :check_session_limit!
  
  def index
    @logins = current_user.logins.order(updated_at: :desc)
  end
end
