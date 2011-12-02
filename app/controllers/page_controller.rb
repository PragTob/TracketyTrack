class PageController < ApplicationController

  def current_sprint
    if Project.all.empty?
      redirect_to new_project_path
    elsif User.all.empty?
      redirect_to new_user_path
    elsif signed_in?
      @project = Project.first
      @user_stories_current_sprint = UserStory.all()
      @user_stories_in_progress = UserStory.where(status: "active")
      @page = "current"
      render 'current_sprint'
    else
      redirect_to signin_path
    end

  end

  def sprint_planning
    @project = Project.first
    @page = "planning"
    render
  end

end

