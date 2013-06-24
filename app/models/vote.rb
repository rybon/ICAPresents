class Vote < ActiveRecord::Base
  belongs_to :student
  belongs_to :award
  belongs_to :project
end
