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
  it { should be_valid }

  it "is invalid without a name" do
    UserStory.new.should_not be_valid
  end

  it "needs a name to be valid" do
    UserStory.new(name: "Work! Work!").should be_valid
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
#

