require 'spec_helper'

describe Project do
  before :all do
    @valid_attributes = Factory.attributes_for(:project)
  end

  before :each do
    @project = Factory.build(:project)
    @user = Factory.build(:user)
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
    Factory.create(:project)

    lambda{Project.create(@valid_attributes)}.should change{
      Project.all.size
    }.by(0)
  end

  it "raises an error when trying to create a second project" do
    Factory.create(:project)

    lambda{Factory.create(:project, title: "bla")}.should raise_error
  end

  describe "#current_sprint" do
    context "when current_sprint_id is not set" do
      it "returns nil" do
        @project.current_sprint_id = nil
        @project.current_sprint.should be_nil
      end
    end
    context "when current_sprint_id is set" do
      it "returns nil" do
        @project.current_sprint_id = 1
        sprint = Factory.build(:sprint)
        Sprint.stub(:find).with(@project.current_sprint_id).and_return(sprint)
        @project.current_sprint.should be sprint
      end
    end
  end

  describe "#current_sprint=" do
    it "set current_sprint_id to id of the given sprint" do
      sprint = Factory.build(:sprint, id: 1)
      @project.current_sprint = sprint
      @project.current_sprint_id.should eq sprint.id
    end
  end

end

