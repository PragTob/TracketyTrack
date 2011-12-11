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

  context "when being saved" do
    before{ @sprint.save }
    it { should be_persisted }
    after{ @sprint.destroy }
  end

  context "without a number" do
    before{ @sprint.number = nil }
    it { should_not be_valid }
  end

  context "when number is already taken" do
    before do
      @sprint2 = Factory(:sprint)
      @sprint.save
    end
    it { should_not be_persisted }
    after { @sprint2.destroy }
  end

  context "when the end date lies before the start date" do
    before { @sprint.start_date, @sprint.end_date = @sprint.end_date, @sprint.start_date }
    it { should_not be_valid }
  end

  context "with a negative velocity" do
    before { @sprint.velocity = -1 }
    it { should_not be_valid }
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

end

