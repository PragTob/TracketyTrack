require "spec_helper"

describe UserStoriesController do
  describe "routing" do

    it "routes to #index" do
      get("/user_stories").should route_to("user_stories#index")
    end

    it "routes to #new" do
      get("/user_stories/new").should route_to("user_stories#new")
    end

    it "routes to #show" do
      get("/user_stories/1").should route_to("user_stories#show", :id => "1")
    end

    it "routes to #edit" do
      get("/user_stories/1/edit").should route_to("user_stories#edit", :id => "1")
    end

    it "routes to #create" do
      post("/user_stories").should route_to("user_stories#create")
    end

    it "routes to #update" do
      put("/user_stories/1").should route_to("user_stories#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/user_stories/1").should route_to("user_stories#destroy", :id => "1")
    end

  end
end
