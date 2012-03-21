require 'spec_helper'

describe Sprint do

  before :each do
    @sprint = FactoryGirl.build(:sprint)
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

  describe "#initial_story_points" do

    it "returns the sum of all story points of the given sprint" do
      @sprint.save
      first_user_story = Factory(:user_story, estimation: 1, sprint: @sprint)
      second_user_story = Factory(:user_story, estimation: 2, sprint: @sprint)
      third_user_story = Factory(:user_story, estimation: 3, sprint: @sprint)
      @sprint.initial_story_points.should eq 6
    end



  end

  describe "#user_stories_estimated" do

    it "returns the user stories with estimation" do
      @sprint.save
      user_story = Factory(:user_story, estimation: 1, sprint: @sprint)
      @sprint.user_stories_estimated.should eq [user_story]
    end

    it "does not contain the user stories without estimation" do
      @sprint.save
      user_story = Factory(:user_story, estimation: nil, sprint: @sprint)
      @sprint.user_stories_estimated.should_not include user_story
    end

  end

  describe "#completed_story_points_per_day" do

    it "returns a collection of completed story points for each day of the sprint" do
      time = DateTime.now.utc
      Timecop.freeze(time)
      @sprint.update_attributes(start_date: time, end_date: time + 4)
      first_user_story = Factory(:user_story, estimation: 1, sprint: @sprint,
        status: UserStory::COMPLETED, close_time: time + 1)
      second_user_story = Factory(:user_story, estimation: 2, sprint: @sprint,
        status: UserStory::COMPLETED, close_time: time + 2)
      third_user_story = Factory(:user_story, estimation: 3, sprint: @sprint,
        status: UserStory::COMPLETED, close_time: time + 3)
      first_day = time.to_date
      date_collection = { first_day.strftime("%d.%m.") => 0,
                          (first_day + 1).strftime("%d.%m.") => 1,
                          (first_day + 2).strftime("%d.%m.") => 2,
                          (first_day + 3).strftime("%d.%m.") => 3,
                          (first_day + 4).strftime("%d.%m.") => 0 }
      @sprint.completed_story_points_per_day.should eq date_collection
    end

  end

  describe "#all_story_points_per_day" do

    it "returns a collection of all story points for each day of the sprint" do
      time = DateTime.now.utc
      Timecop.freeze(time)
      @sprint.update_attributes(start_date: time, end_date: time + 4)
      first_user_story = Factory(:user_story, estimation: 2, sprint: @sprint,
        created_at: time + 1)
      second_user_story = Factory(:user_story, estimation: 3, sprint: @sprint,
        created_at: time + 2)
      third_user_story = Factory(:user_story, estimation: 4, sprint: @sprint,
        created_at: time + 3)
      pre_sprint_created_user_story = Factory(:user_story, estimation: 1,
        sprint: @sprint, created_at: time - 1)
      first_day = time.to_date
      date_collection = { first_day.strftime("%d.%m.") => 1,
                          (first_day + 1).strftime("%d.%m.") => 3,
                          (first_day + 2).strftime("%d.%m.") => 6,
                          (first_day + 3).strftime("%d.%m.") => 10,
                          (first_day + 4).strftime("%d.%m.") => 10 }
      @sprint.all_story_points_per_day.should eq date_collection
    end

  end

  describe "#actual_velocity" do

    it "returns the number of currently completed story points" do
      first_user_story = Factory(:user_story, estimation: 5,
                sprint: @sprint, status: UserStory::COMPLETED)
      second_user_story = Factory(:user_story, estimation: 7,
                sprint: @sprint, status: UserStory::COMPLETED)
      @sprint.actual_velocity.should eq 12
    end

    it "does not consider incomplete user stories" do
      first_user_story = Factory(:user_story, estimation: 5,
                sprint: @sprint, status: UserStory::COMPLETED)
      second_user_story = Factory(:user_story, estimation: 7,
                sprint: @sprint, status: UserStory::ACTIVE)
      @sprint.actual_velocity.should eq 5
    end

    it "does not consider user stories without estimation" do
      first_user_story = Factory(:user_story, estimation: 5,
                sprint: @sprint, status: UserStory::COMPLETED)
      second_user_story = Factory(:user_story, estimation: nil,
                sprint: @sprint, status: UserStory::COMPLETED)
      @sprint.actual_velocity.should eq 5
    end

  end

  describe "#completed_sprints" do

    it "returns all completed sprints" do
      @sprint.update_attributes(end_date: DateTime.now)
      another_sprint = Factory(:sprint, number: 2, end_date: nil)
      Sprint.completed_sprints.should eq [@sprint]
    end

    it "does not contain unfinished sprints" do
      @sprint.update_attributes(end_date: nil)
      Sprint.completed_sprints.should_not include @sprint
    end

  end

  describe "user story helpers" do

    describe "in progress" do

      it "returns an active user story" do
        user_story = FactoryGirl.build(:user_story, status: UserStory::ACTIVE)
        @sprint.user_stories << user_story
        @sprint.user_stories_in_progress.should include user_story
      end

      it "returns a suspended user story" do
        user_story = FactoryGirl.build(:user_story, status: UserStory::SUSPENDED)
        @sprint.user_stories << user_story
        @sprint.user_stories_in_progress.should include user_story
      end

    end

    describe "not in progress" do

      it "returns a completed user story" do
        user_story = FactoryGirl.build(:user_story, status: UserStory::COMPLETED)
        @sprint.user_stories << user_story
        @sprint.user_stories_not_in_progress.should include user_story
      end

      it "returns an inactive user story" do
        user_story = FactoryGirl.build(:user_story, status: UserStory::INACTIVE)
        @sprint.user_stories << user_story
        @sprint.user_stories_not_in_progress.should include user_story
      end

    end

    describe "current user stories for user" do

      before :each do
        @user = FactoryGirl.build(:user)
        @user_story = FactoryGirl.build(:user_story, sprint: @sprint, users: [@user])
      end

      it "returns an active user story a user is working on" do
        @user_story.update_attributes(status: UserStory::ACTIVE)
        @sprint.user_stories_for_user(@user).should include @user_story
      end

      it "returns an suspended user story a user is working on" do
        @user_story.update_attributes(status: UserStory::SUSPENDED)
        @sprint.user_stories_for_user(@user).should include @user_story
      end

      it "returns no inactive user story a user is assigned to" do
       @user_story.update_attributes(status: UserStory::INACTIVE)
        @sprint.user_stories_for_user(@user).should_not include @user_story
      end

      it "does not return user stories from other users" do
        other_user = FactoryGirl.build(:user)
        @user_story.update_attributes(status: UserStory::ACTIVE, users: [other_user])
        @sprint.user_stories_for_user(@user).should_not include @user_story
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

