require File.expand_path(File.dirname(__FILE__)) + '/../spec_helper'

describe ProjectsController do

  before do
    @projects = [mock_model(Project, :id => 42, :name => 'First project')]
  end

  context 'GET /projects' do
    it 'should find existing projects' do
      Project.should_receive(:paginate).and_return(@projects)
      get :index
    end
  end

  context 'GET /projects/:id' do
    it 'should find the requested project' do
      Project.should_receive(:find).with('42').and_return(@projects.first)
      tasks = []
      tasks.stub(:build).and_return(mock_model(Task))
      @projects.first.stub(:tasks).and_return(tasks)
      get :show, :id => 42
    end
  end

  context 'GET /projects/new' do
    context '(logged in)' do
      before do
        @user = User.create!(:username => 'user', :email => 'user@mail.com', :password => 'password', :password_confirmation => 'password')
        sign_in @user
      end

      it 'should create a new project' do
        Project.should_receive(:new)
        get :new
      end
    end

    context '(not logged in)' do
      it 'should not create a new project' do
        Project.should_not_receive(:new)
        get :new
      end
    end
  end

  context 'POST /projects' do
    before do
      @project = mock_model(Project, :name => 'Other Project', :id => 42)
      @project.stub(:save).and_return(true)
      Project.stub(:new).and_return(@project)
    end

    context '(logged in)' do
      before do
        @user = User.create!(:username => 'user', :email => 'user@mail.com', :password => 'password', :password_confirmation => 'password')
        sign_in @user
      end

      it 'should create a new project with the specified attributes' do
        Project.should_receive(:new).with('name' => 'Other Project').and_return(@project)
        post :create, :project => { :name => 'Other Project' }
      end

      context 'with valid params' do
        it 'should save the created project' do
          @project.should_receive(:save).and_return(true)
          post :create, :project => { :name => 'Other Project' }
          response.should redirect_to('/projects/42')
        end
      end

      context 'with invalid params' do
        it 'should render the creation form again' do
          @project.should_receive(:save).and_return(false)
          post :create, :project => { :name => 'Other Project' }
          response.should render_template('projects/new')
        end
      end
    end

    context '(not logged in)' do
      it 'should not create the new project' do 
        Project.should_not_receive(:new)
        post :create, :project => { :name => 'Other Project' }
      end
    end
  end

  context 'GET /projects/:id/edit' do
    context '(logged in)' do
      before do
        @user = User.create!(:username => 'user', :email => 'user@mail.com', :password => 'password', :password_confirmation => 'password')
        sign_in @user
      end

      it 'should find the requested project' do
        Project.should_receive(:find).with('42').and_return(@project)
        get :edit, :id => 42
      end
    end

    context '(not logged in)' do
      it 'should not find the project' do
        Project.should_not_receive(:find)
        get :edit, :id => 42
      end
    end
  end

  context 'PUT /projects/:id' do
    before do
      @project = mock_model(Project, :name => 'Boring Project Name', :id => 69)
      @project.stub(:update_attributes).and_return(true)
      Project.stub(:find).and_return(@project)
    end

    context '(logged in)' do
      before do
        @user = User.create!(:username => 'user', :email => 'user@mail.com', :password => 'password', :password_confirmation => 'password')
        sign_in @user
      end

      it 'should find the requested project' do
        Project.should_receive(:find).with('69').and_return(@project)
        put :update, :id => 69, :project => { :name => 'Some Fancy Project Name' }
      end

      context 'with valid attributes' do
        it 'should update the project attributes' do
          @project.should_receive(:update_attributes).with('name' => 'Some Fancy Project Name').and_return(true)
          put :update, :id => 69, :project => { :name => 'Some Fancy Project Name' }
          response.should redirect_to(@project)
        end
      end

      context 'with invalid attributes' do
        it 'should render the edit form again' do
          @project.should_receive(:update_attributes).with('name' => 'Some Fancy Project Name').and_return(false)
          put :update, :id => 69, :project => { :name => 'Some Fancy Project Name' }
          response.should render_template('projects/edit')
        end
      end
    end

    context '(not logged in)' do
      it 'should not update the attributes' do
        @project.should_not_receive(:update_attributes)
        put :update, :id => 69, :project => { :name => 'Some Fancy Project Name' }
      end
    end
  end

end
