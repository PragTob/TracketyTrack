class UserStoriesController < ApplicationController
  include UserStoriesHelper

  before_filter :authenticate
  before_filter(only: [:update, :create]) {|c| c.add_users(params)}

  def index
    @title = "All User Stories"
    @user_stories = UserStory.all_open
  end

  def current_sprint_list
    @title = "Current Sprint"
    @user_stories = UserStory.current_sprint_stories
    render 'index'
  end

  def completed_stories_list
    @title = "Completed"
    @user_stories = UserStory.completed_stories
    render 'index'
  end

  def work_in_progress_list
    @title = "Work in Progress"
    @user_stories = UserStory.work_in_progress_stories
    render 'index'
  end

  def backlog_list
    @title = "Backlog"
    @user_stories = UserStory.backlog
    render 'index'
  end

  def deleted_list
    @title = "Deleted"
    @user_stories = UserStory.deleted
    render 'index'
  end

  def non_estimated_list
    @title = "Non estimated"
    @user_stories = UserStory.non_estimated
    render 'index'
  end

  def requesting_feedback_list
    @title = "Need Feedback"
    @user_stories = UserStory.requesting_feedback
    render 'index'
  end

  def show
    @user_story = UserStory.find(params[:id])
    @comment = Comment.new
  end

  def new
    @user_story = UserStory.new
    @users = User.all
  end

  def edit
    @user_story = UserStory.find(params[:id])
    @users = User.accepted_users
    @days, @hours, @minutes, @seconds = @user_story.split_work_effort
  end

  def create
    @user_story = UserStory.new(params[:user_story])

    if @user_story.save
      message = 'User Story was successfully created.'

      # if we come from sprint planning, then we wanna stay at that page
      if request.referrer == sprint_planning_url
        redirect_to sprint_planning_path, flash: {success: message}
      else
        redirect_to @user_story, flash: {success: message}
      end
    else
      render "new"
    end
  end

  def update
    @user_story = UserStory.find(params[:id])
    @users = User.all

    if @user_story.update_attributes(params[:user_story])
      @user_story.combine_work_effort Duration.new(params)
      redirect_to @user_story,
                  flash: {success: 'User Story was successfully updated.'}
    else
      render "edit"
    end
  end

  def destroy
    @user_story = UserStory.find(params[:id])
    @user_story.delete

    redirect_to user_stories_url,
                flash: {success: "User Story succesfully deleted" }
  end

  def resurrect
    @user_story = UserStory.find(params[:id])
    @user_story.resurrect

    redirect_to user_stories_url,
                flash: {success: "User Story succesfully resurrected" }
  end

  def start
    @user_story = UserStory.find(params[:id])
    @user_story.start current_user
    @user_story.save

    redirect_to current_sprint_path
  end

  def pause
    @user_story = UserStory.find(params[:id])

    if @user_story.pause current_user
      redirect_to current_sprint_path
    else
      redirect_to current_sprint_path,
                  flash: {error: "You can not pause a user story you are not \
                                  assigned to!"}
    end
  end

  def complete
    @user_story = UserStory.find(params[:id])
    @user_story.complete

    redirect_to current_sprint_path
  end

  def request_feedback
    @user_story = UserStory.find(params[:id])
    @user_story.update_attributes(requesting_feedback: true)
    redirect_to @user_story
  end

  def stop_requesting_feedback
    @user_story = UserStory.find(params[:id])
    @user_story.update_attributes(requesting_feedback: false)
    redirect_to @user_story
  end

  def assign_sprint
    set_sprint(params[:id], current_sprint)
    render partial: 'sprints/current_sprint_user_stories',
        locals: { user_stories_current_sprint: current_sprint.user_stories }
  end

  def unassign_sprint
    set_sprint(params[:id], nil)
    render partial: 'sprints/backlog_user_stories',
        locals: { user_stories_in_backlog: UserStory.backlog }
  end

  def add_user
    with_user_story_and_user(params) do |user_story, user|
      user_story.users << user
    end
    redirect_to current_sprint_path
  end

  def remove_user
    with_user_story_and_user(params) do |user_story, user|
      user_story.users.delete user
    end
    redirect_to current_sprint_path
  end

  def details
    user_story = UserStory.find(params[:id])
    render partial: 'details_page',
        locals: {user_story: user_story, management_allowed: false}
  end
  
  private
  def with_user_story_and_user(params, &block)
    user_story = UserStory.find(params[:id])
    user = User.find(params[:user_id])
    yield user_story, user
    user_story.save
  end

end

