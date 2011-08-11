require File.expand_path(File.dirname(__FILE__)) + '/../spec_helper'

describe 'projects routing' do

  it 'should route to projects listing' do
    { :get => '/projects' }.should route_to(:controller => 'projects', :action => 'index')
  end

  it 'should route to project details' do
    { :get => '/projects/42' }.should route_to(:controller => 'projects', :action => 'show', :id => '42')
  end 

  it 'should route to project creation form' do
    { :get => '/projects/new' }.should route_to(:controller => 'projects', :action => 'new')
  end

  it 'should route to project creation' do
    { :post => '/projects' }.should route_to(:controller => 'projects', :action => 'create')
  end

end
