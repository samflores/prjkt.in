class Project < ActiveRecord::Base
  has_many :tasks
  accepts_nested_attributes_for :tasks

  validates :name, :presence => true
end
