require File.expand_path(File.dirname(__FILE__)) + '/../spec_helper'

feature 'Project details' do
  scenario 'project found' do
    project = Project.create(:name => 'TOP SECRET PROJECT')
    visit "/projects/#{project.id}"
    page.should have_content('TOP SECRET PROJECT')
  end

  scenario 'project not found' do 
    visit '/projects/666'
    page.should have_content("There's no such project")
  end
end
