require File.expand_path(File.dirname(__FILE__)) + '/../spec_helper'

feature 'mark task as done' do
  context '(logged in)' do
    background do
      user = User.create!(:username => 'user', :email => 'user@mail.com', :password => 'sekret', :password_confirmation => 'sekret')
      @project = Project.new(:name => 'Amazing project', :owner => user)
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
      click_button 'Update Tasks'
      page.should have_no_content('Easy task')
    end
  end
end
