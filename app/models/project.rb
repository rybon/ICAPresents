class Project < ActiveRecord::Base
  belongs_to :author, polymorphic: true
  has_many :votes, dependent: :destroy

  validates_presence_of :title, :students, :semester, :location, :time, :description, :picture, message: 'Mag niet leeg zijn.'
end
