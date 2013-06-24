class Student < ActiveRecord::Base
  has_one :project, as: :author, dependent: :destroy
  has_many :votes, dependent: :destroy

  def self.create_from_omniauth(auth)
    create! do |student|
      student.facebook_id = auth['uid']
      student.name = auth['extra']['raw_info']['name']
    end
  end
end
