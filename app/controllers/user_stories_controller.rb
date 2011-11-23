class UserStoriesController < ApplicationController
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
end
