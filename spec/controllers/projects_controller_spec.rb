require File.expand_path(File.dirname(__FILE__)) + '/../spec_helper'

describe ProjectsController do

  before do
    @projs = [mock_model(Project, :id => 42, :name => 'First project')]
  end

  context 'GET /projects' do
    it 'should find existing projects' do
      Project.should_receive(:paginate).and_return(@projs)
      get :index
    end
  end

  context 'GET /projects/:id' do
    it 'should find the requested project' do
      Project.should_receive(:find).with('42').and_return(@projs.first)
      get :show, :id => 42
    end
  end

  context 'GET /projects/new' do
    it 'should create a new project' do
      Project.should_receive(:new)
      get :new
    end
  end

  context 'POST /projects' do
    before do
      @project = mock_model(Project, :name => 'Other Project', :id => 42)
      @project.stub(:save).and_return(true)
      Project.stub(:new).and_return(@project)
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

  context 'GET /projects/:id/edit' do
    it 'should find the requested project' do
      Project.should_receive(:find).with('42').and_return(@project)
      get :edit, :id => 42
    end
  end

  context 'PUT /projects/:id' do
    before do
      @project = mock_model(Project, :name => 'Boring Project Name', :id => 69)
      # @project.stub(:save).and_return(true)
      @project.stub(:update_attributes).and_return(true)
      Project.stub(:find).and_return(@project)
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

end
