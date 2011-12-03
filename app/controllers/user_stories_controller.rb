class UserStoriesController < ApplicationController
  include UserStoriesHelper

  before_filter :authenticate

  # GET /user_stories
  # GET /user_stories.json
  def index
    @user_stories = UserStory.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @user_stories }
    end
  end

  # GET /user_stories/1
  # GET /user_stories/1.json
  def show
    @user_story = UserStory.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user_story }
    end
  end

  # GET /user_stories/new
  # GET /user_stories/new.json
  def new
    @user_story = UserStory.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user_story }
    end
  end

  # GET /user_stories/1/edit
  def edit
    @user_story = UserStory.find(params[:id])
  end

  # POST /user_stories
  # POST /user_stories.json
  def create
    @user_story = UserStory.new(params[:user_story])
    @user_story.status = "inactive"

    respond_to do |format|
      if @user_story.save
        format.html { redirect_to @user_story, notice: 'User story was successfully created.' }
        format.json { render json: @user_story, status: :created, location: @user_story }
      else
        format.html { render action: "new" }
        format.json { render json: @user_story.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /user_stories/1
  # PUT /user_stories/1.json
  def update
    @user_story = UserStory.find(params[:id])

    respond_to do |format|
      if @user_story.update_attributes(params[:user_story])
        format.html { redirect_to @user_story, notice: 'User story was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @user_story.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_stories/1
  # DELETE /user_stories/1.json
  def destroy
    @user_story = UserStory.find(params[:id])
    @user_story.destroy

    respond_to do |format|
      format.html { redirect_to user_stories_url }
      format.json { head :ok }
    end
  end

  # POST /user_stories/1
  def start
    @user_story = UserStory.find(params[:id])
    @user_story.status = "active"
    @user_story.user = current_user
    current_user.user_stories << @user_story
    @user_story.save
    current_user.save

    respond_to do |format|
      format.html { redirect_to current_sprint_path }
      format.json { head :ok }
    end
  end

  # POST /user_stories/1
  def complete
    @user_story = UserStory.find(params[:id])
    @user_story.status = "completed"
    @user_story.save

    respond_to do |format|
      format.html { redirect_to current_sprint_path }
      format.json { head :ok }
    end
  end

  # PUT /user_stories/1
  def assign_sprint
    set_sprint(params[:id], current_sprint)
    respond_to do |format|
      format.html { redirect_to sprint_planning_path }
      format.json { head :ok }
    end
  end

  # PUT /user_stories/1
  def unassign_sprint
    set_sprint(params[:id], nil)

    respond_to do |format|
      format.html { redirect_to sprint_planning_path }
      format.json { head :ok }
    end
  end

end

