require "spec_helper"

describe SprintsController do
  describe "routing" do

    it "routes to #index" do
      get("/sprints").should route_to("sprints#index")
    end

    it "routes to #new" do
      get("/sprints/new").should route_to("sprints#new")
    end

    it "routes to #show" do
      get("/sprints/1").should route_to("sprints#show", :id => "1")
    end

    it "routes to #edit" do
      get("/sprints/1/edit").should route_to("sprints#edit", :id => "1")
    end

    it "routes to #create" do
      post("/sprints").should route_to("sprints#create")
    end

    it "routes to #update" do
      put("/sprints/1").should route_to("sprints#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/sprints/1").should route_to("sprints#destroy", :id => "1")
    end

  end
end
