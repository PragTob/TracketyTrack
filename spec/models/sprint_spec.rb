require 'spec_helper'

describe Sprint do
  before :each do
    @sprint = Factory.build(:sprint)
  end

  subject{@sprint}

  it { should respond_to :number }
  it { should respond_to :start_date }
  it { should respond_to :end_date }
  it { should respond_to :velocity }
  it { should respond_to :user_stories }
  it { should be_valid }

  it "is valid without a velocity" do
    @sprint.velocity = nil
    @sprint.should be_valid
  end

  context "without a number" do
    before{ @sprint.number = nil }
    it { should_not be_valid }
  end

  context "when number is already taken" do
    before { @sprint2 = Factory(:sprint) }
    it { should_not be_valid }
  end

  context "when the end date lies before the start date" do
    before { @sprint.start_date, @sprint.end_date = @sprint.end_date, @sprint.start_date }
    it { should_not be_valid }
  end

  context "with a negative velocity" do
    before { @sprint.velocity = -1 }
    it { should_not be_valid }
  end

  context "without an end date" do
    before { @sprint.end_date = nil }
    it { should be_valid }
  end

  context "with overlapping dates" do

    before (:each) do
        @sprint2 = Factory(:sprint, number: 2)
    end
    context "when the new start date lies within an other sprint" do

      before do
        @sprint.start_date = @sprint2.start_date + 1
        @sprint.end_date = @sprint2.end_date + 1
      end

      it { should_not be_valid }

    end

    context "when the new end date lies within an other sprint" do

      before do
        @sprint.start_date = @sprint2.start_date - 1
        @sprint.end_date = @sprint2.end_date - 1
      end

      it { should_not be_valid }

    end

  end

  describe ".actual_sprint?" do

    it "returns true if a sprint is defined containing the current date" do
      Factory(:sprint, start_date: DateTime.now, end_date: DateTime.now + 1)
      Sprint.actual_sprint?.should be_true
    end

  end

  describe ".actual_sprint" do

    context "when there is one sprint, which contains the current date" do
      it "returns this sprint" do
        sprint = Factory(:sprint, start_date: DateTime.now,
                                  end_date: DateTime.now + 1)
        Sprint.actual_sprint.should eq sprint
      end
    end

    context "when there is no sprint containing the current date" do
      it "returns nil" do
        Sprint.actual_sprint.should eq nil
      end
    end

  end

  describe "#expired?" do

    it "returns true if the end date is older than the current date" do
      sprint = Factory.build(:sprint, end_date: DateTime.now - 1)
      sprint.expired?.should be_true
    end

  end

  describe "user story helpers" do

    describe "in progress" do

      it "returns an active user story" do
        user_story = Factory.build(:user_story, status: UserStory::ACTIVE)
        @sprint.user_stories << user_story
        @sprint.user_stories_in_progress.should include user_story
      end

      it "returns a suspended user story" do
        user_story = Factory.build(:user_story, status: UserStory::SUSPENDED)
        @sprint.user_stories << user_story
        @sprint.user_stories_in_progress.should include user_story
      end

    end

    describe "not in progress" do

      it "returns a completed user story" do
        user_story = Factory.build(:user_story, status: UserStory::COMPLETED)
        @sprint.user_stories << user_story
        @sprint.user_stories_not_in_progress.should include user_story
      end

      it "returns an inactive user story" do
        user_story = Factory.build(:user_story, status: UserStory::INACTIVE)
        @sprint.user_stories << user_story
        @sprint.user_stories_not_in_progress.should include user_story
      end

    end

  end

  it "can stop the sprint when the end date is nil" do
    sprint = Factory :sprint, end_date: nil
    time = DateTime.now
    Timecop.freeze time
    sprint.end
    sprint.end_date.to_i.should eq time.to_i
  end

end

# == Schema Information
#
# Table name: sprints
#
#  id          :integer         not null, primary key
#  number      :integer
#  start_date  :datetime
#  end_date    :datetime
#  velocity    :integer
#  created_at  :datetime
#  updated_at  :datetime
#  description :text
#

