require 'spec_helper'

def add_users_to_story
  @user_story.users << Factory.build(:user) << Factory.build(:other_user)
end

# more examples to come when the model gets more complex
describe UserStory do
  before :each do
    @user_story = Factory.build(:user_story)
  end

  subject{@user_story}

  it { should respond_to :name }
  it { should respond_to :description }
  it { should respond_to :acceptance_criteria }
  it { should respond_to :priority }
  it { should respond_to :estimation }
  it { should respond_to :status }
  it { should respond_to :users }
  it { should respond_to :sprint }
  it { should respond_to :work_effort }
  it { should respond_to :start_time }
  it { should be_valid }

  context "when being saved" do
    before{ @user_story.save }
    it { should be_persisted }
    after{ @user_story.destroy }
  end

  it "is invalid without a name" do
    UserStory.new.should_not be_valid
  end

  it "is valid with just a name" do
    UserStory.new(name: "blaaa").should be_valid
  end

  it "is invalid without a work effort" do
    Factory.build(:user_story, work_effort: nil).should_not be_valid
  end

  context "with a status unlike inactive, active, suspended or completed" do
    before{ @user_story.status = "foo" }
    it {should_not be_valid}
  end

  describe "#short_description" do

    it "returns a shortened description" do
      @user_story.description = "tr" + "ol" * 100
      @user_story.short_description.length.should eq 200
      @user_story.short_description.start_with?("trolololol").should be_true
    end

  end

  describe "#set_new_work_effort" do

    it "adds the time difference between the start time and now to the work effort" do
      @user_story.start_time = DateTime.now
      DateTime.stub(:now).and_return @user_story.start_time + 1
      @user_story.work_effort = 1

      @user_story.set_new_work_effort
      @user_story.work_effort.should eq 2
    end

  end

  describe "#printable_work_effort" do

    it "does not fail when no work effort is set" do
      @user_story.work_effort = nil
      lambda {
        @user_story.printable_work_effort }.should_not raise_error
    end

    it "returns a string representing the used work effort" do
      @user_story.work_effort = 1
      @user_story.printable_work_effort.should eq "0 days 00:00:01"
    end

  end

  describe "#backlog" do

    it "returns all user stories without assigned sprint" do
      user_story = Factory(:user_story, sprint: nil)
      UserStory.backlog.should eq [user_story]
    end

    it "does not contain user stories with assigned sprint" do
      sprint = Factory(:sprint)
      @user_story.update_attributes(sprint_id: sprint.id)
      UserStory.backlog.should_not include @user_story
    end

  end

  describe "#current_sprint_stories" do

    it "returns all user stories of the current sprint" do
      sprint = Factory(:sprint)
      project = Factory(:project, current_sprint: sprint)
      @user_story.update_attributes(sprint: sprint)
      UserStory.current_sprint_stories.should eq [@user_story]
    end

    it "does not contain user stories that are not assigned to a sprint" do
      sprint = Factory(:sprint)
      project = Factory(:project, current_sprint: sprint)
      UserStory.current_sprint_stories.should_not include @user_story
    end

    it "does not contain user stories that are assigned to an other sprint than the current one" do
      current_sprint = Factory(:sprint)
      project = Factory(:project, current_sprint: current_sprint)
      another_sprint = Sprint.create(number: 2)
      @user_story.update_attributes(sprint: another_sprint)
      UserStory.current_sprint_stories.should_not include @user_story
    end

    it "returns empty collection if there is no current sprint" do
      project = Factory(:project)
      UserStory.current_sprint_stories.should eq []
    end

  end

  describe "#completed_stories" do

    it "returns all completed user stories" do
      @user_story.update_attributes(status: UserStory::COMPLETED)
      UserStory.completed_stories.should eq [@user_story]
    end

    it "does not contain suspended user stories" do
      @user_story.update_attributes(status: UserStory::SUSPENDED)
      UserStory.completed_stories.should_not include @user_story
    end

    it "does not contain inactive user stories" do
      @user_story.update_attributes(status: UserStory::INACTIVE)
      UserStory.completed_stories.should_not include @user_story
    end

    it "does not contain active user stories" do
      @user_story.update_attributes(status: UserStory::ACTIVE)
      UserStory.completed_stories.should_not include @user_story
    end

  end

  describe "#non_estimated" do

    it "returns all user stories without estimation" do
      @user_story.update_attributes(estimation: nil)
      UserStory.non_estimated.should eq [@user_story]
    end

    it "does not contain user stories with estimation" do
      @user_story.update_attributes(estimation: 1)
      UserStory.non_estimated.should_not include @user_story
    end

  end

  describe "#work_in_progress_stories" do

    it "returns all active user stories" do
      @user_story.update_attributes(status: UserStory::ACTIVE)
      UserStory.work_in_progress_stories.should eq [@user_story]
    end

    it "does not contain suspended user stories" do
      @user_story.update_attributes(status: UserStory::SUSPENDED)
      UserStory.work_in_progress_stories.should_not include @user_story
    end

    it "does not contain inactive user stories" do
      @user_story.update_attributes(status: UserStory::INACTIVE)
      UserStory.work_in_progress_stories.should_not include @user_story
    end

    it "does not contain completed user stories" do
      @user_story.update_attributes(status: UserStory::COMPLETED)
      UserStory.work_in_progress_stories.should_not include @user_story
    end

  end

  it "is valid with multiple users assigned" do
    add_users_to_story
    @user_story.should be_valid
  end

  it "has an appropriate users size" do
    add_users_to_story
    @user_story.users.size.should be 2
  end

  it "doesn't have duplicated users" do
    user = Factory :user
    @user_story.users << user << user
    @user_story.users.size.should be 1
  end

end

# == Schema Information
#
# Table name: user_stories
#
#  id                  :integer         not null, primary key
#  name                :string(255)
#  description         :text
#  acceptance_criteria :text
#  priority            :integer
#  estimation          :integer
#  created_at          :datetime
#  updated_at          :datetime
#  status              :string(255)
#  sprint_id           :integer
#

