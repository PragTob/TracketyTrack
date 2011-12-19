require 'spec_helper'

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

