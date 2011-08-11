require File.expand_path(File.dirname(__FILE__)) + '/../spec_helper'

describe 'projects routing' do

  it 'should route to projects listing' do
    { :get => '/projects' }.should route_to(:controller => 'projects', :action => 'index')
  end

end
