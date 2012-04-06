require 'spec_helper'

describe Project do
  before :all do
    @valid_attributes = FactoryGirl.attributes_for(:project)
  end

  before :each do
    @project = FactoryGirl.build(:project)
    @user = FactoryGirl.build(:user)
  end

  subject{@project}

  it{should respond_to :title}
  it{should respond_to :description}
  it{should respond_to :repository_url}
  it{should respond_to :current_sprint}
  it { should be_valid }

  it "is invalid without a title" do
    Project.new(@valid_attributes.merge(title: nil)).should_not be_valid
  end

  it "exists only maximum one project at a time" do
    FactoryGirl.create(:project)

    lambda{Project.create(@valid_attributes)}.should change{
      Project.all.size
    }.by(0)
  end

  it "raises an error when trying to create a second project" do
    FactoryGirl.create(:project)

    lambda{FactoryGirl.create(:project, title: "bla")}.should raise_error
  end

  describe "#current_sprint" do

    context "when current_sprint_id is not set" do
      it "returns nil" do
        @project.current_sprint_id = nil
        @project.current_sprint.should be_kind_of NullSprint
      end
    end

    context "when current_sprint_id is set" do
      it "returns the curent sprint" do
        @project.current_sprint_id = 1
        sprint = FactoryGirl.build(:sprint)
        Sprint.stub(:find).with(@project.current_sprint_id).and_return(sprint)
        @project.current_sprint.should be sprint
      end
    end

  end

  describe "#average_velocity" do

    it "returns the average of all velocities (for completed sprints)" do
      time = DateTime.now
      first_sprint = FactoryGirl.build(:sprint, number: 1, end_date: time)
      second_sprint = FactoryGirl.build(:sprint, number: 2, end_date: time)
      first_sprint.stub(actual_velocity: 10)
      second_sprint.stub(actual_velocity: 30)
      Sprint.stub all: [first_sprint, second_sprint]
      @project.average_velocity.should eq 20
    end

    it "returns 0 if there are no completed sprints" do
      @project.average_velocity.should eq 0
    end

  end

  describe "#completed_story_points_per_sprint" do

    it "returns a collection of all burnt down story points per sprint" do
      time = DateTime.now
      first_sprint = FactoryGirl.build(:sprint, number: 1, end_date: time)
      second_sprint = FactoryGirl.build(:sprint, number: 2, end_date: time)
      first_sprint.stub(actual_velocity: 10)
      second_sprint.stub(actual_velocity: 30)
      Sprint.stub all: [first_sprint, second_sprint]
      story_points_collection = {1 => 10, 2 => 30}
      @project.completed_story_points_per_sprint.should eq story_points_collection
    end

  end

  describe "#all_story_points_per_sprint" do

    it "returns a collection of all story points created until end of sprint" do
      time = DateTime.now
      first_sprint = FactoryGirl.build(:sprint, number: 1, end_date: time)
      second_sprint = FactoryGirl.build(:sprint, number: 2, end_date: time + 2)
      first_user_story = FactoryGirl.build(:user_story,
                                      created_at: time - 1,
                                      estimation: 10)
      second_user_story = FactoryGirl.build(:user_story,
                                        created_at: time + 1,
                                        estimation: 20)
      Sprint.stub completed_sprints: [first_sprint, second_sprint]
      UserStory.stub all: [first_user_story, second_user_story]
      story_points_collection = {1 => 10, 2 => 30}
      @project.all_story_points_per_sprint.should eq story_points_collection
    end

  end

  describe "#initial_story_points" do

    it "returns the sum of all story points" do
      user_story = FactoryGirl.build(:user_story, estimation: 5)
      UserStory.stub(:all).and_return([user_story, user_story])
      @project.initial_story_points.should eq 10
    end

    it "does not consider user stories without estimation" do
      user_story = FactoryGirl.build(:user_story, estimation: 5)
      user_story_without_estimation = FactoryGirl.build(:user_story, estimation: nil)
      UserStory.stub(all: [user_story, user_story_without_estimation])
      @project.initial_story_points.should eq 5
    end

  end


  describe "#current_sprint=" do

    context "when sprint id is given" do

        it "sets current_sprint_id to id of the given sprint" do
          sprint = FactoryGirl.build(:sprint, id: 1)
          @project.current_sprint = sprint
          @project.current_sprint_id.should eq sprint.id
        end

    end

    context "when nil is given" do
      it "sets the current_sprint_id to nil" do
        @project.current_sprint = nil
        @project.current_sprint_id.should be_nil
      end
    end

  end

  describe "project_settings" do

    it "has project settings after being initialized" do
      Project.new(title: "Title").project_settings.should_not be nil
    end

  end

  describe "destroy" do
    it "works" do
      @project.destroy
      Project.all.should be_empty
    end
  end

end

# == Schema Information
#
# Table name: projects
#
#  id                :integer         not null, primary key
#  title             :string(255)
#  description       :text
#  repository_url    :string(255)
#  created_at        :datetime
#  updated_at        :datetime
#  current_sprint_id :integer
#

