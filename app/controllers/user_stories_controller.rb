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
    @days, @hours, @minutes, @seconds = @user_story.split_work_effort
  end

  def create
    @user_story = UserStory.new(params[:user_story])

    if @user_story.save
      redirect_to @user_story, 
                  flash: {success: 'User Story was successfully created.'}
    else
      render action: "new"
    end
  end

  def update
    @user_story = UserStory.find(params[:id])
    @users = User.all

    if @user_story.update_attributes(params[:user_story])
      @user_story.combine_work_effort params[:days].to_i, params[:hours].to_i,
                                      params[:minutes].to_i,
                                      params[:seconds].to_i

      redirect_to @user_story, 
                  flash: {success: 'User Story was successfully updated.'}
    else
      render action: "edit" 
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

    redirect_to current_sprint_path
  end

  def pause
    @user_story = UserStory.find(params[:id])
    
    # TODO get this into the pause method
    if @user_story.users.include? current_user
      @user_story.pause

      redirect_to current_sprint_path
    else
      redirect_to current_sprint_path
    end
  end

  def complete
    @user_story = UserStory.find(params[:id])
    @user_story.complete

    redirect_to current_sprint_path
  end

  def assign_sprint
    set_sprint(params[:id], current_sprint)
    redirect_to sprint_planning_path
  end

  def unassign_sprint
    set_sprint(params[:id], nil)
    redirect_to sprint_planning_path
  end

end

