module UserStoriesHelper

  def set_sprint(id, sprint)
    @user_story = UserStory.find(id)
    @user_story.sprint = sprint
    @user_story.save
  end

  def add_users params
    params[:user_story][:users] ||= []
    params[:user_story][:users].map! { |user_id| User.find(user_id) }
  end

end

