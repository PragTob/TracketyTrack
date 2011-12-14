class PageController < ApplicationController
  before_filter :redirect_and_login_check

  def current_sprint_overview

    if current_sprint.nil?
      @user_stories_current_sprint = []
      @user_stories_in_progress = []
    else
      @user_stories_current_sprint = current_sprint.user_stories
      @user_stories_current_sprint = @user_stories_current_sprint.select{|each| each.status == "inactive" or each.status == "completed"}
      @user_stories_in_progress = current_sprint.user_stories.select{|each| each.status == "active" or each.status == "suspended"}
    end

    @page = "current"
    render 'current_sprint'
  end

  def sprint_planning
    if current_sprint.nil?
      @user_stories_current_sprint = []
    else
      @user_stories_current_sprint = current_sprint.user_stories
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

