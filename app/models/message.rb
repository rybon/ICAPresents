class Message < ActiveRecord::Base
  belongs_to :teacher

  validates_presence_of :content, message: 'Can not be empty'
  validates_length_of :content, maximum: 255, message: 'Can not be longer than 255 characters'
end
