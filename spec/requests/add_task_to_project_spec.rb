require File.expand_path(File.dirname(__FILE__)) + '/../spec_helper'

feature 'Add task to project' do
  scenario 'with valid attributes' do 
    project = Project.create(:name => 'Mega Project')
    visit "/projects/#{project.id}"
    fill_in 'Task', :with => 'Sketch the world domination plan'
    fill_in 'Due date', :with => '2012-12-21'
    click_button 'Add Task'
    page.should have_content('Task successufully added to project')
    page.should have_content('Sketch the world domination plan')
  end
  
  scenario 'with invalid attributes' do
    project = Project.create(:name => 'Mega Project')
    visit "/projects/#{project.id}"
    fill_in 'Due date', :with => '2012-12-21'
    click_button 'Add Task'
    page.should have_content('Unable to add task to project')
    page.should have_content('Tasks title can\'t be blank')
  end
end
