class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.authenticate(params[:session][:email],
                             params[:session][:password])
    if user.nil?
      redirect_to signin_path, flash: {error: "Invalid email or password"}
    else
      sign_in user
      redirect_to root_path
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end

end

