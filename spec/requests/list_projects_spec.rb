require File.expand_path(File.dirname(__FILE__)) + '/../spec_helper'

feature 'Projects Listing' do
  scenario 'no existing project' do
    visit '/projects'
    page.should have_content('No projects yet. Create one now')
  end

  scenario 'some projects registered' do
    projects = (1..5).to_a.map {|n| mock_model(Project, :name => "Project #{n}")}
    Project.stub(:paginate).and_return(projects)
    visit '/projects'
    page.should have_content('Project 1')
    page.should have_content('Project 2')
    page.should have_content('Project 3')
    page.should have_content('Project 4')
    page.should have_content('Project 5')
  end

  scenario 'lots of projects registered' do
    projects = (1..15).to_a.map {|n| mock_model(Project, :name => "Project #{n}")}
    Project.stub(:paginate).and_return(projects[0,10])
    visit '/projects'
    (1..10).each  { |n| page.should have_content("Project #{n}") }
    (11..15).each { |n| page.should_not have_content("Project #{n}") }
  end
end
