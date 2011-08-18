class Project < ActiveRecord::Base
  belongs_to :owner, :class_name => 'User'
  has_many :tasks
  accepts_nested_attributes_for :tasks, :reject_if => proc { |task| task[:id].nil? and ( task[:title].nil? or task[:title].empty? ) }

  validates :name, :presence => true
  validates :owner, :presence => true
end
