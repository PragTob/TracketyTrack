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

end

