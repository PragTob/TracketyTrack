class PageController < ApplicationController
  def index
    if Project.all.empty?
      redirect_to new_project_path
    elsif User.all.empty?
      redirect_to new_user_path
    else
      @project = Project.first
      render
    end

  end

end

