module UserStoriesHelper

  def set_sprint(id, sprint)
    @user_story = UserStory.find(id)
    @user_story.sprint = sprint
    @user_story.save
  end

  def add_users params
    params[:user_story][:users] ||= []
    # ignore the empty value added by rails 3.2
    params[:user_story][:users].delete ""
    params[:user_story][:users].map! { |user_id| User.find(user_id) }
  end

end

