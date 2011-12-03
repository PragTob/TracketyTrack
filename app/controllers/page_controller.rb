class PageController < ApplicationController
  before_filter :redirect_and_login_check

  def current_sprint
    @project = Project.first
    if @project.current_sprint.nil?
      @user_stories_current_sprint = []
      @user_stories_in_progress = []
    else
      @user_stories_current_sprint = @project.current_sprint.user_stories
      @user_stories_current_sprint = @user_stories_current_sprint.select{|each| each.status == "inactive" or each.status == "completed"}
      @user_stories_in_progress = @project.current_sprint.user_stories.select{|each| each.status == "active"}
    end

    @page = "current"
    render 'current_sprint'
  end

  def sprint_planning
    @project = Project.first
    if @project.current_sprint.nil?
      @user_stories_current_sprint = []
    else
      @user_stories_current_sprint = @project.current_sprint.user_stories
    end
    @user_stories_in_backlog = UserStory.backlog
    @page = "planning"
    render 'sprint_planning'
  end

  # TODO: Remove me!!
  def create_demo_sprint
    @project = Project.first
    @sprint = Sprint.new(number: 1, start_date: 1.day.ago, end_date: Time.now, velocity: 1)
    @sprint.save
    @project.update_attributes(current_sprint: @sprint)

    respond_to do |format|
      format.html { redirect_to "/sprint_planning" }
      format.json { head :ok }
    end
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

