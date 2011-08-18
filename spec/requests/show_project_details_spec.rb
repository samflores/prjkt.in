require File.expand_path(File.dirname(__FILE__)) + '/../spec_helper'

feature 'Project details' do
  scenario 'project found' do
    user = User.create!(:username => 'user', :email => 'manager@server.com', :password => 'sekret', :password_confirmation => 'sekret')
    project = Project.create(:name => 'TOP SECRET PROJECT', :owner => user )
    visit "/projects/#{project.id}"
    page.should have_content('TOP SECRET PROJECT')
  end

  scenario 'project not found' do 
    visit '/projects/666'
    page.should have_content("There's no such project")
  end
end
