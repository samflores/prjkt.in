require File.expand_path(File.dirname(__FILE__)) + '/../spec_helper'

feature 'mark task as done', :js => true do
  context '(logged in)' do
    background do
      User.create!(:username => 'user', :email => 'user@mail.com', :password => 'sekret', :password_confirmation => 'sekret')
      @project = Project.new(:name => 'Amazing project')
      @project.tasks << Task.new(:title => 'Easy task')
      @project.save!
      visit '/users/sign_in'
      fill_in 'Username', :with => 'user'
      fill_in 'Password', :with => 'sekret'
      click_button 'Sign in'
    end

    scenario 'default scenario' do
      visit "/projects/#{@project.id}"
      check 'Easy task'
      page.should have_no_content('Easy task')
    end
  end
end
