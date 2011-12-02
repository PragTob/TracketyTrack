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

  it "can be created with valid attributes" do
    Project.new(@valid_attributes).should be_valid
  end

  it "is invalid without a name" do
    Project.new(@valid_attributes.merge(title: nil)).should_not be_valid
  end

  it "exists only maximum one project at a time" do
    @project.save
    Project.create(@valid_attributes).should_not be_valid
  end

end

