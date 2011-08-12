require File.expand_path(File.dirname(__FILE__)) + '/../spec_helper'

feature 'Create new Project' do
  context ', when logged in as "user",' do
    before do
      user = User.create!(:username => 'user', :email => 'manager@server.com', :password => 'sekret', :password_confirmation => 'sekret')
      visit '/users/sign_in'
      fill_in 'Username', :with => 'user'
      fill_in 'Password', :with => 'sekret'
      click_button 'Sign in'
    end

    scenario 'with valid attributes' do
      visit '/projects/new'
      page.should_not have_content('You need to sign in or sign up before continuing')
      fill_in 'Name', :with => 'Super cool project'
      click_button 'Create Project'
      page.should have_content('Super cool project')
      page.should have_content('Project successfully saved')
    end

    scenario 'with empty name' do
      visit '/projects/new'
      click_button 'Create Project'
      page.should have_content('Unable to save project')
      page.should have_content('Name can\'t be blank')
    end
  end

  scenario 'not logged in' do
    visit '/projects/new'
    page.should have_content('You need to sign in or sign up before continuing')
  end
end
