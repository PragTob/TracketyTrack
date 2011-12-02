module UserStoriesHelper
  def set_sprint(id, sprint)
    @user_story = UserStory.find(id)
    @user_story.sprint = sprint
    @user_story.save
  end
end

