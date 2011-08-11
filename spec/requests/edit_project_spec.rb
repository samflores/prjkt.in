require File.expand_path(File.dirname(__FILE__)) + '/../spec_helper'

feature 'Edit project' do
  background do
    @project = Project.create(:name => 'forty-two')
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
