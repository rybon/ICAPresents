class Message < ActiveRecord::Base
  belongs_to :teacher

  validates_presence_of :content, message: 'Mag niet leeg zijn.'
  validates_length_of :content, maximum: 255, message: 'Mag niet langer dan 255 tekens zijn.'
end
