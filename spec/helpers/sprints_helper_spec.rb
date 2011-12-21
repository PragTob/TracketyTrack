require 'spec_helper'

describe SprintsHelper do

  describe "form_action_for" do

    it 'returns "Start" when sprint is a new record' do
      sprint = Factory.build(:sprint)
      form_action_for(sprint).should eq "Start"
    end

    it 'returns "Edit" when sprint is not a new record (is edited)' do
      sprint = Factory(:sprint)
      form_action_for(sprint).should eq "Edit"
    end

  end

end
