class SprintsController < ApplicationController
  include SprintsHelper

  dashboard_actions = [:current_sprint_overview, :sprint_planning]
  before_filter :authenticate, except: dashboard_actions
  before_filter :redirect_and_login_check, only: dashboard_actions

  def index
    @sprints = Sprint.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sprints }
    end
  end

  def show
    @sprint = Sprint.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @sprint }
    end
  end

  def new
    @sprint = Sprint.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @sprint }
    end
  end

  def edit
    @sprint = Sprint.find(params[:id])
  end

  def create
    @sprint = Sprint.new(params[:sprint])
    @sprint.start_date ||= DateTime.now

    respond_to do |format|
      if @sprint.save
        self.current_sprint = @sprint if Sprint.actual_sprint == @sprint
        format.html { redirect_to sprint_planning_path,
                      flash: { success: 'Sprint was successfully created.'} }
        format.json { render json: @sprint, status: :created, location: @sprint }
      else
        format.html { render action: "new" }
        format.json { render json: @sprint.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @sprint = Sprint.find(params[:id])

    respond_to do |format|
      if @sprint.update_attributes(params[:sprint])
        format.html { redirect_to @sprint, flash: {success: 'Sprint was successfully updated.'} }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @sprint.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @sprint = Sprint.find(params[:id])
    @sprint.destroy

    respond_to do |format|
      format.html { redirect_to sprints_url }
      format.json { head :ok }
    end
  end

#  def start

#    if Sprint.actual_sprint?
#      self.current_sprint = Sprint.actual_sprint
#      respond_to do |format|
#        format.html { redirect_to sprint_planning_path, flash:
#                      {success: "Sprint #{current_sprint.number} was started." +
#                      "It is planned to end #{current_sprint.end_date}"} }
#      end
#    else
#      respond_to do |format|
#        format.html { redirect_to new_sprint_url }
#        format.json { head :ok }
#      end
#    end

#  end

  def stop
    current_sprint.end
    self.current_sprint = nil

    respond_to do |format|
      format.html { redirect_to sprint_planning_path }
      format.json { head :ok }
    end

  end

  def current_sprint_overview

    @user_stories_current_sprint = current_sprint.user_stories_not_in_progress
    @user_stories_in_progress = current_sprint.user_stories_in_progress

    @page = "current"
    render 'current_sprint'
  end

  def sprint_planning
    @user_stories_current_sprint = current_sprint.user_stories
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
      authenticate
    end
  end

end

