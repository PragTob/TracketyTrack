require 'spec_helper'

describe SprintsHelper do

  describe "form_action_for" do

    it 'returns "Start" when sprint is a new record' do
      sprint = FactoryGirl.build(:sprint)
      form_action_for_sprint(sprint).should eq "Start"
    end

    it 'returns "Edit" when sprint is not a new record (is edited)' do
      sprint = FactoryGirl.create(:sprint)
      form_action_for_sprint(sprint).should eq "Edit"
    end

  end


end

