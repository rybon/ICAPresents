class Project < ActiveRecord::Base
  belongs_to :author, polymorphic: true
  has_many :votes, dependent: :destroy

  validates_presence_of :title, :students, :semester, :location, :time, :description, :picture, message: 'Can not be empty'
  validates_length_of :title, :students, :semester, :location, :time, :picture, maximum: 255, message: 'Can not be longer than 255 characters'
end
