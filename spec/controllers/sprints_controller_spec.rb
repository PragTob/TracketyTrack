require 'spec_helper'

describe SprintsController do

  def valid_attributes
    Factory.attributes_for(:sprint)
  end

  describe "you need to be logged in for all sprint actions" do

    before :each do
      sign_in_a_user
      @project = Factory(:project)
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

        it "redirects to the sprint planning modus" do
          post :create, :sprint => valid_attributes
          response.should redirect_to(sprint_planning_path)
        end

        describe "when no start date is given" do
          before :each do
            @time = DateTime.now
            Timecop.freeze(@time)
          end

          it "sets the start date to now" do
            post :create, sprint: valid_attributes.merge(start_date: nil)
            assigns(:sprint).start_date.to_i.should == @time.to_i
          end

          describe "and no end date is given" do
            it "does not raise an error" do
              lambda do
                post :create, sprint: valid_attributes.merge(start_date: nil,
                                                             end_date: nil)
              end.should_not raise_error
            end
          end
        end

        describe "when created sprint is actual sprint" do

          it "starts this sprint" do
            attributes = valid_attributes.merge(start_date: DateTime.now - 1,
                                                end_date: DateTime.now + 1)
            post :create, :sprint => attributes
            @project = Project.find(@project.id)
            @project.current_sprint.should eq assigns(:sprint)
          end

        end

      end

      describe "with invalid params" do

        it "assigns a newly created but unsaved sprint as @sprint" do
          Sprint.any_instance.stub(:save).and_return(false)
          post :create, :sprint => {}
          assigns(:sprint).should be_a_new(Sprint)
        end

        it "re-renders the 'new' template" do
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
          Sprint.any_instance.stub(:save).and_return(false)
          put :update, :id => sprint.id, :sprint => {}
          assigns(:sprint).should eq(sprint)
        end

        it "re-renders the 'edit' template" do
          sprint = Sprint.create! valid_attributes
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

    describe "PUT stop" do

      before :each do
        @sprint = Factory(:sprint, end_date: DateTime.now - 1)
        @project.current_sprint = @sprint
        @time = DateTime.now
        Timecop.freeze(@time)
        put :stop
      end

      it "sets the end date of the current sprint to the actual date" do
        Sprint.find(@sprint.id).end_date.to_i.should eq @time.to_i
      end

      it "makes the current sprint no longer current" do
        Project.find(@project.id).current_sprint.should be_kind_of NullSprint
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

  describe "Sprint dashboard actions" do

    before (:each) do
      @project = Factory(:project)
    end

    describe "GET 'sprint_planning'" do

      before(:each) do
         @user_story = Factory(:user_story, status: "inactive")
         @other_user_story = Factory(:user_story, status: "inactive")
         sign_in_a_saved_user
      end

      describe "with current sprint" do

        before(:each) do
          @sprint = Factory(:sprint)
          @project.update_attributes(current_sprint: @sprint)
          @project.save
          @user_story.update_attributes(sprint: @sprint)
          @user_story.save
        end

        it "selects all inactive user stories of the current sprint" do
          get :sprint_planning
          assigns(:user_stories_current_sprint).should eq [@user_story]
        end

        it "selects all user stories of the backlog" do
          get :sprint_planning
          assigns(:user_stories_in_backlog).should eq [@other_user_story]
        end

      end

      describe "without current sprint" do

        it "selects empty collection for current sprint" do
          get :sprint_planning
          assigns(:user_stories_current_sprint).should eq []
        end

        it "selects all user stories of the product laptop" do
          get :sprint_planning
          assigns(:user_stories_in_backlog).should eq [@user_story,
                                                       @other_user_story]
        end

      end

      describe "when project exists and user is signed in" do
        it "returns success and renders sprint_planning" do
          get 'sprint_planning'
          response.should be_success
          response.should render_template("sprint_planning")
        end
      end

    end

    describe "GET 'current_sprint'" do

      describe "with current sprint" do

        before(:each) do
          @user_story = Factory(:user_story, status: "inactive")
          @other_user_story = Factory(:user_story, status: "active")
          @sprint = Factory(:sprint)
          @project.update_attributes(current_sprint: @sprint)
          @user_story.update_attributes(sprint: @sprint)
          @other_user_story.update_attributes(sprint: @sprint)
          sign_in_a_saved_user
        end

        it "selects all inactive user stories of the current sprint" do
          get :current_sprint_overview
          assigns(:user_stories_current_sprint).should eq [@user_story]
        end

        it "selects all active user stories of the current sprint" do
          get :current_sprint_overview
          assigns(:user_stories_in_progress).should eq [@other_user_story]
        end

      end

      describe "without current sprint" do

        it "selects empty collections" do
          sign_in_a_saved_user
          get :current_sprint_overview
          assigns(:user_stories_current_sprint).should eq []
          assigns(:user_stories_in_progress).should eq []
        end

      end

      describe "when project exists and user is logged in" do

        it "is successful and renders current_sprint" do
          sign_in_a_saved_user
          get :current_sprint_overview
          response.should be_success
          response.should render_template("current_sprint")
        end

      end

      describe "when no project exists" do

        it "redirects to the new project page" do
          @project.destroy
          get :current_sprint_overview
          response.should redirect_to new_project_path
        end

      end

      describe "when no user was created" do

        it "redirects to the new user page" do
          get :current_sprint_overview
          response.should redirect_to new_user_path
        end

      end

      describe "when user is not signed in" do

        it "redirects to the sign_in page" do
          Factory :user
          controller.should_not be_signed_in
          get :current_sprint_overview
          response.should redirect_to signin_path
        end

      end

    end

  end

end

