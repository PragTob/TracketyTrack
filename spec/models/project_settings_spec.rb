require 'spec_helper'

describe ProjectSettings do

  before :each do
    @project_settings = FactoryGirl.build :project_settings
  end

  subject {@project_settings}
  it { should respond_to :travis_ci_repo }

  describe "Travis" do

    before :each do
        @project = FactoryGirl.build :project
        @project_settings.project = @project
      end

    OWNER_AND_NAME = 'PragTob/TracketyTrack'
    GOOD_URL = "https://github.com/PragTob/TracketyTrack"
    BAD_URL = "https://PragTob@someotherhoster.com/PragTob/TracketyTrack.git"

    describe "owner_and_name" do

      it "works for the homepage of the github repository" do
        @project.repository_url = GOOD_URL
        @project_settings.send(:owner_and_name).should eq OWNER_AND_NAME
      end

      it "works for the SSH of the github repository" do
        @project.repository_url = "git@github.com:PragTob/TracketyTrack.git"
        @project_settings.send(:owner_and_name).should eq OWNER_AND_NAME
      end

      it "works for the HTTP of the github repository" do
        @project.repository_url = "https://PragTob@github.com/PragTob/TracketyTrack.git"
        @project_settings.send(:owner_and_name).should eq OWNER_AND_NAME
      end

      it "returns nil for a non github repository" do
        @project.repository_url = BAD_URL
        @project_settings.send(:owner_and_name).should eq ""
      end

    end

    describe "check_travis_repo" do

      it "returns owner and name when there is a repository" do
        Travis::API::Client::Repositories.stub(fetch: true)
        Travis::API::Client::Repositories.stub(slug: Travis::API::Client::Repositories)


        @project.repository_url = GOOD_URL
        @project_settings.send(:check_travis_repo).should eq OWNER_AND_NAME
      end

      it "returns nil when it the travis API returns nil" do
        Travis::API::Client::Repositories.stub(fetch: nil)

        @project.repository_url = BAD_URL
        @project_settings.send(:check_travis_repo).should eq nil
      end

      it "returns nil when a socket error is raised" do
        Travis::API::Client::Repositories.stub(:slug).and_raise(SocketError)

        @project.repository_url = GOOD_URL
        @project_settings.send(:check_travis_repo).should eq nil
      end

      it "returns nil when a timeout error is raised" do
        Travis::API::Client::Repositories.stub(:slug).and_raise(Timeout::Error)

        @project.repository_url = GOOD_URL
        @project_settings.send(:check_travis_repo).should eq nil
      end

      it "returns nil when a socket error is raised" do
        Travis::API::Client::Repositories.stub(:slug).and_raise(Errno::ECONNRESET)

        @project.repository_url = GOOD_URL
        @project_settings.send(:check_travis_repo).should eq nil
      end

    end

  end

end

# == Schema Information
#
# Table name: project_settings
#
#  id                  :integer         not null, primary key
#  travis_ci_repo      :string(255)
#  travis_last_updated :datetime
#  project_id          :integer
#  created_at          :datetime        not null
#  updated_at          :datetime        not null
#

