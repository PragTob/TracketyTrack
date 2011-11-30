class SessionsController < ApplicationController

  def create
    user = User.authenticate(params[:session][:email],
                             params[:session][:password])
    if user.nil?
      redirect_to users_path, flash: {error: "Invalid email or password"}
    else
      sign_in user
      redirect_to root_path
    end
  end

  def destroy
  end

end

