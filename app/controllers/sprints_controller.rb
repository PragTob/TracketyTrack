class SprintsController < ApplicationController
  include SprintsHelper

  dashboard_actions = [:current_sprint_overview, :sprint_planning]
  before_filter :authenticate, except: dashboard_actions
  before_filter :redirect_and_login_check, only: dashboard_actions

  def index
    @sprints = Sprint.all
  end

  def show
    @sprint = Sprint.find(params[:id])
  end

  def new
    @sprint = Sprint.new
  end

  def edit
    @sprint = Sprint.find(params[:id])
  end

  def create
    @sprint = Sprint.new(params[:sprint])
    @sprint.start_date ||= DateTime.now

    if @sprint.save
      self.current_sprint = @sprint
      redirect_to sprint_planning_path,
                    flash: { success: 'Sprint was successfully created.'}
    else
      render action: "new"
    end
  end

  def update
    @sprint = Sprint.find(params[:id])

    if @sprint.update_attributes(params[:sprint])
      redirect_to @sprint, flash: {success: 'Sprint was successfully updated.'}
    else
      render action: "edit"
    end
  end

  def destroy
    @sprint = Sprint.find(params[:id])
    @sprint.destroy

    redirect_to sprints_url
  end

  def stop
    current_sprint.end
    self.current_sprint = nil

    redirect_to sprint_planning_path
  end

  def current_sprint_overview
    @user_stories_current_sprint = current_sprint.user_stories_not_in_progress
    @user_stories_in_progress = current_sprint.user_stories_in_progress

    @page = "current"
  end

  def sprint_planning
    @user_stories_current_sprint = current_sprint.user_stories
    @user_stories_in_backlog = UserStory.backlog

    @page = "planning"
  end

  private
  def redirect_and_login_check
    if Project.all.empty?
      redirect_to new_project_path
    elsif User.all.empty?
      redirect_to new_user_path
    else
      authenticate
    end
  end

end

