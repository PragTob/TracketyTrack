require 'spec_helper'

describe SprintsController do

  def valid_attributes
    Factory.attributes_for(:sprint)
  end

  describe "you need to be logged in for all sprint actions" do

    before :each do
      sign_in_a_user
    end

    describe "GET index" do
      it "assigns all sprints as @sprints" do
        sprint = Sprint.create! valid_attributes
        get :index
        assigns(:sprints).should eq([sprint])
      end
    end

    describe "GET show" do
      it "assigns the requested sprint as @sprint" do
        sprint = Sprint.create! valid_attributes
        get :show, :id => sprint.id
        assigns(:sprint).should eq(sprint)
      end
    end

    describe "GET new" do
      it "assigns a new sprint as @sprint" do
        get :new
        assigns(:sprint).should be_a_new(Sprint)
      end
    end

    describe "GET edit" do
      it "assigns the requested sprint as @sprint" do
        sprint = Sprint.create! valid_attributes
        get :edit, :id => sprint.id
        assigns(:sprint).should eq(sprint)
      end
    end

    describe "POST create" do

      describe "with valid params" do

        it "creates a new Sprint" do
          expect {
            post :create, :sprint => valid_attributes
          }.to change(Sprint, :count).by(1)
        end

        it "assigns a newly created sprint as @sprint" do
          post :create, :sprint => valid_attributes
          assigns(:sprint).should be_a(Sprint)
          assigns(:sprint).should be_persisted
        end

        it "redirects to the created sprint" do
          post :create, :sprint => valid_attributes
          response.should redirect_to(Sprint.last)
        end

        describe "when no start date is given" do

          it "sets the start date to now" do
            Factory(:project)
            post :create, :sprint => valid_attributes.merge(start_date: nil)
            assigns(:sprint).start_date.to_date.should eq DateTime.now.to_date
          end

        end

        describe "when created sprint is actual sprint" do

          it "starts this sprint" do
            project = Factory(:project)
            attributes = valid_attributes.merge(start_date: DateTime.now - 1,
                                                end_date: DateTime.now + 1)
            post :create, :sprint => attributes
            project = Project.find(project.id)
            project.current_sprint.should eq assigns(:sprint)
          end

        end

      end

      describe "with invalid params" do

        it "assigns a newly created but unsaved sprint as @sprint" do
          # Trigger the behavior that occurs when invalid params are submitted
          Sprint.any_instance.stub(:save).and_return(false)
          post :create, :sprint => {}
          assigns(:sprint).should be_a_new(Sprint)
        end

        it "re-renders the 'new' template" do
          # Trigger the behavior that occurs when invalid params are submitted
          Sprint.any_instance.stub(:save).and_return(false)
          post :create, :sprint => {}
          response.should render_template("new")
        end

      end

    end

    describe "PUT update" do

      describe "with valid params" do

        it "updates the requested sprint" do
          sprint = Sprint.create! valid_attributes
          Sprint.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
          put :update, :id => sprint.id, :sprint => {'these' => 'params'}
        end

        it "assigns the requested sprint as @sprint" do
          sprint = Sprint.create! valid_attributes
          put :update, :id => sprint.id, :sprint => valid_attributes
          assigns(:sprint).should eq(sprint)
        end

        it "redirects to the sprint" do
          sprint = Sprint.create! valid_attributes
          put :update, :id => sprint.id, :sprint => valid_attributes
          response.should redirect_to(sprint)
        end

      end

      describe "with invalid params" do

        it "assigns the sprint as @sprint" do
          sprint = Sprint.create! valid_attributes
          # Trigger the behavior that occurs when invalid params are submitted
          Sprint.any_instance.stub(:save).and_return(false)
          put :update, :id => sprint.id, :sprint => {}
          assigns(:sprint).should eq(sprint)
        end

        it "re-renders the 'edit' template" do
          sprint = Sprint.create! valid_attributes
          # Trigger the behavior that occurs when invalid params are submitted
          Sprint.any_instance.stub(:save).and_return(false)
          put :update, :id => sprint.id, :sprint => {}
          response.should render_template("edit")
        end

      end

    end

    describe "DELETE destroy" do

      it "destroys the requested sprint" do
        sprint = Sprint.create! valid_attributes
        expect {
          delete :destroy, :id => sprint.id
        }.to change(Sprint, :count).by(-1)
      end

      it "redirects to the sprints list" do
        sprint = Sprint.create! valid_attributes
        delete :destroy, :id => sprint.id
        response.should redirect_to(sprints_url)
      end

    end

#    describe "PUT start" do

#      describe "when there is one sprint containing the current date" do

#        before :each do
#          @sprint = Factory(:sprint, start_date: DateTime.now - 1,
#                                    end_date: DateTime.now + 1)
#          @project = Factory(:project)
#          put :start
#        end

#        it "sets this sprint as current sprint" do
#          project = Project.find(@project.id)
#          project.current_sprint.should eq @sprint
#        end

#        it "redirects to the sprint planning page" do
#          response.should redirect_to sprint_planning_path
#        end

#      end

#      describe "when there is one sprint containing the current date" do

#        it "redirects to the create sprint page" do
#          put :start
#          response.should redirect_to new_sprint_url
#        end

#      end

#    end

    describe "PUT stop" do

      before :each do
        @sprint = Factory(:sprint, end_date: DateTime.now - 1)
        @project = Factory(:project)
        @project.current_sprint = @sprint
        put :stop
      end

      it "sets the end date of the current sprint to the actual date" do
        Sprint.find(@sprint.id).end_date.to_date.should eq DateTime.now.to_date
      end

      it "makes the current sprint no longer current" do
        project = Project.find(@project.id).current_sprint.should be_nil
      end

      it "redirects to the sprint planning page" do
        response.should redirect_to sprint_planning_path
      end

    end

  end



  describe "A logged out user can do nothing" do

    it "can't access new" do
      get :new
      response.should redirect_to signin_path
    end

    it "can't access create" do
      post :create
      response.should redirect_to signin_path
    end

    it "can't access index" do
      get :index
      response.should redirect_to signin_path
    end

    it "can't access edit" do
      get :edit, id: 1
      response.should redirect_to signin_path
    end

    it "can't access update" do
      put :update, id: 1
      response.should redirect_to signin_path
    end

    it "can't access destroy" do
      delete :destroy, id: 1
      response.should redirect_to signin_path
    end

    it "can't access show" do
      get :show, id: 1
      response.should redirect_to signin_path
    end

  end

end

