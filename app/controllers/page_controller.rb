class PageController < ApplicationController
  before_filter :redirect_and_login_check

  def current_sprint
    @project = Project.first
    @user_stories_current_sprint = UserStory.all()
    @user_stories_in_progress = UserStory.where(status: "active")
    @page = "current"
    render 'current_sprint'
  end

  def sprint_planning
    @project = Project.last
    @page = "planning"
    render
  end

  protected
    def redirect_and_login_check
      if Project.all.empty?
        redirect_to new_project_path
      elsif User.all.empty?
        redirect_to new_user_path
      else
        unless signed_in?
          redirect_to signin_path
        end
      end
    end

end

