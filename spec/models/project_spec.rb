require File.expand_path(File.dirname(__FILE__)) + '/../spec_helper'

describe Project do
  it 'should not be valid without a name' do
    project = Project.new :name => nil
    project.should_not be_valid
  end
end
