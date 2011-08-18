require File.expand_path(File.dirname(__FILE__)) + '/../spec_helper'

feature 'Add task to project' do
    before do
      user = User.create!(:username => 'user', :email => 'manager@server.com', :password => 'sekret', :password_confirmation => 'sekret')
      visit '/users/sign_in'
      fill_in 'Username', :with => 'user'
      fill_in 'Password', :with => 'sekret'
      click_button 'Sign in'
    end
    
  scenario 'with valid attributes' do 
    project = Project.create(:name => 'Mega Project')
    visit "/projects/#{project.id}"
    fill_in 'Task', :with => 'Sketch the world domination plan'
    fill_in 'Due date', :with => '2012-12-21'
    click_button 'Update Tasks'
    page.should have_content('Project tasks successfully updated')
    page.should have_content('Sketch the world domination plan')
  end
  
  scenario 'with empty title' do
    project = Project.create(:name => 'Mega Project')
    visit "/projects/#{project.id}"
    fill_in 'Due date', :with => '2012-12-21'
    click_button 'Update Tasks'
    page.should have_content('Project tasks successfully updated')
    project.tasks.count.should == 0
  end
end
