require File.expand_path(File.dirname(__FILE__)) + '/../spec_helper'

feature 'Create new Project' do
  scenario 'valid attributes' do
    visit '/projects/new'
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
