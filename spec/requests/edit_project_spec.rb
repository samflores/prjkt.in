require File.expand_path(File.dirname(__FILE__)) + '/../spec_helper'

feature 'Edit project' do
  background do
    user = User.create!(:username => 'user', :email => 'manager@server.com', :password => 'sekret', :password_confirmation => 'sekret')
    @project = Project.create(:name => 'forty-two', :owner => user)
  end
    
  context ', when loged in as "user",' do
    before do
      visit '/users/sign_in'
      fill_in 'Username', :with => 'user'
      fill_in 'Password', :with => 'sekret'
      click_button 'Sign in'
    end

    scenario 'with valid attributes' do
      visit "/projects/#{@project.id}/edit"
      fill_in 'Name', :with => 'Life, the Universe and Everything'
      click_button 'Update Project'
      page.should have_content('Project successfully updated')
      page.should have_content('Life, the Universe and Everything')
    end

    scenario 'with empty name' do
      visit "/projects/#{@project.id}/edit"
      fill_in 'Name', :with => ''
      click_button 'Update Project'
      page.should have_content('Unable to update project')
      page.should have_content('Name can\'t be blank')
    end
  end

  scenario 'not logged in' do
    visit "/projects/#{@project.id}/edit"
    page.should have_content('You need to sign in or sign up before continuing')
  end
end
