class ContactController < ApplicationController
  before_filter :authenticate_user!
  before_filter :device_excited
  before_filter :session_limit
  
  def index
  end
end
