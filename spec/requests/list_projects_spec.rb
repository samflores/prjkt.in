require File.expand_path(File.dirname(__FILE__)) + '/../spec_helper'

feature 'Projects Listing' do
  scenario 'no existing project' do
    visit '/projects'
    page.should have_content('No projects yet. Create one now')
  end

  scenario 'some projects registered' do
    projects = (1..5).to_a.map {|n| Project.create(:name => "Project #{n}")}
    visit '/projects'
    (1..5).each { |n| page.should have_content("Project #{n}") }
    page.should_not have_content("Next")
  end

  scenario 'lots of projects registered' do
    projects = (1..15).to_a.map {|n| Project.create(:name => "Project #{n}")}
    visit '/projects'
    (1..10).each  { |n| page.should have_content("Project #{n}") }
    (11..15).each { |n| page.should_not have_content("Project #{n}") }
    page.should have_content("Next")
  end
end
