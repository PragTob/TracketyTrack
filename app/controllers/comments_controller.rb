class CommentsController < ApplicationController

  def create
    @comment = Comment.new(params[:comment])
    @comment.date = DateTime.now
    @comment.user = current_user

    if @comment.save
      redirect_to @comment.user_story
    else
      redirect_to request.referrer, error: "Something went wrong with saving the comment"
    end

  end

  def destroy
    @comment = Comment.find(params[:id])
    user_story = @comment.user_story
    @comment.destroy

    redirect_to user_story
  end
  
end

