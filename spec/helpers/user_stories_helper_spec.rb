describe UserStoriesHelper do

  it "set the sprint to the given value" do
    @user_story = Factory(:user_story)
    @sprint = Factory.build(:sprint)
    set_sprint(@user_story.id, @sprint)
    UserStory.find(@user_story.id).sprint.should eq @sprint
  end

end

