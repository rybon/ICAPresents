class Message < ActiveRecord::Base
  belongs_to :teacher

  validates_presence_of :content, message: 'Mag niet leeg zijn.'
end
