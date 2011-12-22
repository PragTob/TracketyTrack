class PageController < ApplicationController
  before_filter :redirect_and_login_check

  def current_sprint_overview

    if current_project.has_current_sprint?
      @user_stories_current_sprint = current_sprint.user_stories_not_in_progress
      @user_stories_in_progress = current_sprint.user_stories_in_progress
    else
      @user_stories_current_sprint = []
      @user_stories_in_progress = []
    end

    @page = "current"
    render 'current_sprint'
  end

  def sprint_planning
    if current_project.has_current_sprint?
      @user_stories_current_sprint = current_sprint.user_stories
    else
      @user_stories_current_sprint = []
    end
    @user_stories_in_backlog = UserStory.backlog
    @page = "planning"
    render 'sprint_planning'
  end

  private
    def redirect_and_login_check
      if Project.all.empty?
        redirect_to new_project_path
      elsif User.all.empty?
        redirect_to new_user_path
      else
        redirect_to signin_path unless signed_in?
      end
    end

end

