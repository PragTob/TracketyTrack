class ProjectController < ApplicationController

  def index

  end

  def register
    if request.post?
      @user = User.create(params[:user])
      if not @user.errors.any?
        redirect_to "index"
      end
    end
  end

end

