class UserStoriesController < ApplicationController
  include UserStoriesHelper

  before_filter :authenticate
  before_filter(only: [:update, :create]) {|c| c.add_users(params)}

  def index
    @title = "All Stories"
    @user_stories = UserStory.all_open
  end

  def current_sprint_list
    @title = "User Stories of the Current Sprint"
    @user_stories = UserStory.current_sprint_stories
    render 'index'
  end

  def completed_stories_list
    @title = "Completed User Stories"
    @user_stories = UserStory.completed_stories
    render 'index'
  end

  def work_in_progress_list
    @title = "Work in Progress User Stories"
    @user_stories = UserStory.work_in_progress_stories
    render 'index'
  end

  def backlog_list
    @title = "Backlog User Stories"
    @user_stories = UserStory.backlog
    render 'index'
  end

  def deleted_list
    @title = "Deleted User Stories"
    @user_stories = UserStory.deleted
    render 'index'
  end

  def non_estimated_list
    @title = "Non estimated User Stories"
    @user_stories = UserStory.non_estimated
    render 'index'
  end

  def show
    @user_story = UserStory.find(params[:id])
  end

  def new
    @user_story = UserStory.new
    @users = User.all
  end

  def edit
    @user_story = UserStory.find(params[:id])
    @users = User.all
  end

  def create
    @user_story = UserStory.new(params[:user_story])

    respond_to do |format|
      if @user_story.save
        format.html { redirect_to @user_story, flash: {success: 'User Story was successfully created.'} }
        format.json { render json: @user_story, status: :created, location: @user_story }
      else
        format.html { render action: "new" }
        format.json { render json: @user_story.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @user_story = UserStory.find(params[:id])
    @users = User.all

    respond_to do |format|
      if @user_story.update_attributes(params[:user_story])
        format.html { redirect_to @user_story, flash: {success: 'User Story was successfully updated.'} }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @user_story.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user_story = UserStory.find(params[:id])
    @user_story.delete

    redirect_to user_stories_url, flash: {success: "User Story succesfully deleted" }
  end

  def resurrect
    @user_story = UserStory.find(params[:id])
    @user_story.resurrect

    redirect_to user_stories_url, flash: {success: "User Story succesfully resurrected" }
  end

  def start
    @user_story = UserStory.find(params[:id])
    @user_story.start current_user
    @user_story.save

    respond_to do |format|
      format.html { redirect_to current_sprint_path }
      format.json { head :ok }
    end
  end

  def pause
    @user_story = UserStory.find(params[:id])
    # TODO get this into the pause method
    if @user_story.users.include? current_user
      @user_story.pause

      respond_to do |format|
        format.html { redirect_to current_sprint_path }
        format.json { head :ok }
      end
    else
      respond_to do |format|
        format.html { redirect_to current_sprint_path }
        format.json { render json: @user_story.errors, status: :unprocessable_entity }
      end
    end
  end

  def complete
    @user_story = UserStory.find(params[:id])
    @user_story.complete

    respond_to do |format|
      format.html { redirect_to current_sprint_path }
      format.json { head :ok }
    end
  end

  def assign_sprint
    set_sprint(params[:id], current_sprint)
    respond_to do |format|
      format.html { redirect_to sprint_planning_path }
      format.json { head :ok }
    end
  end

  def unassign_sprint
    set_sprint(params[:id], nil)

    respond_to do |format|
      format.html { redirect_to sprint_planning_path }
      format.json { head :ok }
    end
  end

end

