require 'spec_helper'

describe ProjectsController do

  # This should return the minimal set of attributes required to create a valid
  # Project. As you add validations to Project, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    Factory.attributes_for(:project)
  end

  def create_project
    @project = Project.create! valid_attributes
  end

  describe "GET show" do
    it "assigns the requested @project as @@project" do
      create_project
      get :show, :id => @project.id
      assigns(:project).should eq(@project)
    end
  end

  describe "GET new" do
    it "assigns a new @project as @@project" do
      get :new
      assigns(:project).should be_a_new(Project)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Project" do
        expect {
          post :create, :project => valid_attributes
        }.to change(Project, :count).by(1)
      end

      it "assigns a newly created @project as @@project" do
        post :create, :project => valid_attributes
        assigns(:project).should be_a(Project)
        assigns(:project).should be_persisted
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved @project as @@project" do
        # Trigger the behavior that occurs when invalid params are submitted
        Project.any_instance.stub(:save).and_return(false)
        post :create, :project => {}
        assigns(:project).should be_a_new(Project)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Project.any_instance.stub(:save).and_return(false)
        post :create, :project => {}
        response.should render_template("new")
      end
    end
  end

  describe "Actions that need a logged in user" do

    before :each do
      sign_in_a_user
      create_project
    end

    describe "PUT update" do
      describe "with valid params" do

        it "updates the requested @project" do
          # Assuming there are no other projects in the database, this
          # specifies that the Project created on the previous line
          # receives the :update_attributes message with whatever params are
          # submitted in the request.
          Project.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
          put :update, :id => @project.id, :project => {'these' => 'params'}
        end

        it "assigns the requested @project as @@project" do
          put :update, :id => @project.id, :project => valid_attributes
          assigns(:project).should eq(@project)
        end

        it "redirects to the @project" do
          put :update, :id => @project.id, :project => valid_attributes
          response.should redirect_to(@project)
        end
      end

      describe "with invalid params" do

        it "assigns the @project as @@project" do
          # Trigger the behavior that occurs when invalid params are submitted
          Project.any_instance.stub(:save).and_return(false)
          put :update, :id => @project.id, :project => {}
          assigns(:project).should eq(@project)
        end

        it "re-renders the 'edit' template" do
          # Trigger the behavior that occurs when invalid params are submitted
          Project.any_instance.stub(:save).and_return(false)
          put :update, :id => @project.id, :project => {}
          response.should render_template("edit")
        end
      end

    end

    describe "DELETE destroy" do
      it "destroys the requested @project" do
        expect {
          delete :destroy, :id => @project.id
        }.to change(Project, :count).by(-1)
      end

      it "redirects to the projects list" do
        delete :destroy, :id => @project.id
        response.should redirect_to(projects_url)
      end
    end

    describe "GET edit" do

      it "assigns the requested @project as @@project" do
        get :edit, :id => @project.id
        assigns(:project).should eq(@project)
      end
    end

  end

  describe "Acces denied for the following actions without a logged in user" do

    it "can not access update" do
      put :update, id: 1
      response.should redirect_to signin_path
    end

    it "can not access edit" do
      get :edit, id: 1
      response.should redirect_to signin_path
    end

    it "can not access destroy" do
      delete :destroy, id: 1
      response.should redirect_to signin_path
    end

  end

end

