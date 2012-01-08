require 'spec_helper'

describe TravisHelper do

  OWNER_AND_NAME = 'PragTob/TracketyTrack'

  describe "owner_and_name_from" do

    it "works for the homepage of the github repository" do
      name = owner_and_name_from("https://github.com/PragTob/TracketyTrack")
      name.should eq OWNER_AND_NAME
    end

    it "works for the SSH of the github repository" do
      name = owner_and_name_from("git@github.com:PragTob/TracketyTrack.git")
      name.should eq OWNER_AND_NAME
    end

    it "works for the HTTP of the github repository" do
      name = owner_and_name_from("https://PragTob@github.com/PragTob/TracketyTrack.git")
      name.should eq OWNER_AND_NAME
    end

    it "returns nil for a non github repository" do
      name = owner_and_name_from("https://PragTob@someotherhoster.com/PragTob/TracketyTrack.git")
      name.should eq nil
    end

  end

  describe "travis_repo_from" do

    it "returns owner and name when appropriate" do
      Travis::API::Client::Repositories.stub(fetch: true)
      Travis::API::Client::Repositories.stub(slug: Travis::API::Client::Repositories)


      name = travis_repo_from "https://github.com/PragTob/TracketyTrack"
      name.should eq OWNER_AND_NAME
    end

    it "returns nil when it the travis API returns nil" do
      Travis::API::Client::Repositories.stub(fetch: nil)

      name = travis_repo_from "https://PragTob@someotherhoster.com/PragTob/TracketyTrack.git"
      name.should eq nil
    end

  end

end

