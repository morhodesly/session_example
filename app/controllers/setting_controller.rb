class SettingController < ApplicationController
  before_filter :authenticate_user!
  before_filter :check_session_limit!
  
  def index
  end
end
