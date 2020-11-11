class LoginsController < ApplicationController
  def destroy
    @login = current_user.logins.find(params[:id])
    @login.destroy
  end
end
