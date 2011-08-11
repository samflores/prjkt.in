require File.expand_path(File.dirname(__FILE__)) + '/../spec_helper'

describe Task do
  it 'should not be valid without a title' do
    task = Task.new(:title => nil)
    task.should_not be_valid
  end
end
