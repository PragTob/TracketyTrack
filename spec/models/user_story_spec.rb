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
  it { should be_valid }

  context "when being saved" do
    before{ @user_story.save }
    it { should be_persisted }
    after{ @user_story.destroy }
  end

  it "is invalid without a name" do
    UserStory.new.should_not be_valid
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
#  user_id             :integer
#  sprint_id           :integer
#

