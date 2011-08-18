class Project < ActiveRecord::Base
  has_many :tasks
  accepts_nested_attributes_for :tasks, :reject_if => proc { |task| task[:id].nil? and ( task[:title].nil? or task[:title].empty? ) }

  validates :name, :presence => true
end
