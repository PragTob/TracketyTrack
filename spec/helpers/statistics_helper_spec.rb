require 'spec_helper'

describe StatisticsHelper do

  describe "get_axis_scale" do

    it "returns [0,0,0] if initial is 0" do
      get_axis_scale(0).should eq [0,0,0]
    end

    it "returns [0,0,0] if initial is negative" do
      get_axis_scale(-10).should eq [0,0,0]
    end

    it "returns 0 as minimal axis scale (1. entry)" do
      get_axis_scale(10)[0].should eq 0
    end

    it "returns the initial rounded up to the next 10 as maximum (2. entry)" do
      max_value = 25
      get_axis_scale(max_value)[1].should be >= max_value
    end

  end

  describe "get_completed_story_points" do

    it "returns an empty string if there are no units" do
      get_completed_story_points({}).should eq ""
    end

    it "returns value of unit as string" do
      completed_story_points_per_unit = {1 => 10}
      get_completed_story_points(completed_story_points_per_unit).should eq "10"
    end

    it "returns all values as string, added up and separated by a comma" do
      completed_story_points_per_unit = {1 => 10, 2 =>15, 3 => 20}
      get_completed_story_points(completed_story_points_per_unit).should eq "10,25,45"
    end

  end

  describe "get_legend_dates" do

    it "returns an empty string if there are no units" do
      get_legend_dates({}).should eq ""
    end

    it "returns value of unit as string" do
      completed_story_points_per_unit = {1 => 10}
      get_legend_dates(completed_story_points_per_unit).should eq "1"
    end

    it "returns all values as string, separated by a streak" do
      completed_story_points_per_unit = {1 => 10, 2 =>15, 3 => 20}
      get_legend_dates(completed_story_points_per_unit).should eq "1|2|3"
    end

  end

  describe "get_line_dates" do

    it "returns an empty string if there are no units" do
      get_line_dates({}).should eq ""
    end

    it "returns value of unit as string" do
      completed_story_points_per_unit = {1 => 10}
      get_line_dates(completed_story_points_per_unit).should eq "10"
    end

    it "returns all values as string, separated by a comma" do
      completed_story_points_per_unit = {1 => 10, 2 =>15, 3 => 20}
      get_line_dates(completed_story_points_per_unit).should eq "10,15,20"
    end

  end

end

