require File.expand_path(File.dirname(__FILE__)) + '/../spec_helper'

describe ProjectsController do

  context 'GET /projects' do
    before do
      @projs = [mock_model(Project, :name => 'First project')]
    end

    it 'should find existing projects' do
      Project.should_receive(:paginate).and_return(@projs)
      get :index
    end
  end

end
