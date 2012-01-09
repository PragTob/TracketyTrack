require 'spec_helper'

describe Comment do

  before :each do
    @comment = Factory.build(:comment)
  end

  subject{@comment}

  it{should respond_to :content}
  it{should respond_to :date}
  it{should respond_to :user_story}
  it{should respond_to :user}

  context "given valid attributes" do
    it{should be_valid}
  end

  context "without a date" do
    before { @comment.date = nil }
    it{should_not be_valid}
  end

end

# == Schema Information
#
# Table name: comments
#
#  id            :integer         not null, primary key
#  user_story_id :integer
#  user_id       :integer
#  date          :datetime
#  content       :text
#  created_at    :datetime
#  updated_at    :datetime
#

