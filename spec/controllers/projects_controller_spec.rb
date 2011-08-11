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

  context 'GET /projects/:index' do
    it 'should find the requested project' do
      Project.should_receive(:find).with('42').and_return(@projs.first)
      get :show, :id => 42
    end
  end

end
