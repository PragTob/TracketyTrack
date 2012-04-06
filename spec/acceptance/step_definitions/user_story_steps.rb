steps_for :user_story do

  CHANGED_NAME = "changed name"

  step "there is a user story" do
    @user_story = Factory(:user_story)
  end

  step "I should see the name of the user story" do
    page.should have_content(@user_story.name)
  end

  step "I create a new user story" do
    @user_story = FactoryGirl.build(:user_story)
    visit new_user_story_path
    fill_in 'Name', with: @user_story.name
    click_on 'Create User story'
  end

  step "I see this user story in the user story overview" do
    visit user_stories_path
    page.should have_content(@user_story.name)
  end

  step "I am on the page of the user story" do
    visit user_story_path(@user_story)
  end

  step "I add a comment" do
    @comment = "This is just an awesome comment totally adding value!"
    fill_in 'comment_content', with: @comment
    click_on 'Create Comment'
  end

  step "I delete the comment" do
    pending "Need a working login/data with selenium in advance"
    page.evaluate_script("window.confirm = function(msg) { return true; }")
    find(".comment_content_box").click_on 'Delete'
  end

  step "the comment is displayed on the user story page" do
    page.should have_content @comment
  end

  step "the comment is not displayed on the user story page" do
    page.should_not have_content @comment
  end

  step "there is a commented user story" do
    @user_story = FactoryGirl.build :user_story
    @comment = FactoryGirl.build :comment
    @comment.user = User.first
    @user_story.comments << @comment
    @user_story.save
  end

  step "I edit the name of the user story" do
    visit edit_user_story_path(@user_story)
    fill_in "Name", with: CHANGED_NAME
    click_on "Update User story"
  end

  step "I see the changed name" do
    page.should have_content CHANGED_NAME
  end

end

