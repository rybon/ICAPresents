class Home < ActiveRecord::Base
  self.table_name = "home"

  validate :ica_presents_begins_is_valid_datetime

  def ica_presents_begins_is_valid_datetime
    errors.add(:ica_presents_begins, 'Must be a valid date') if ((DateTime.parse(ica_presents_begins.to_s) rescue ArgumentError) == ArgumentError)
  end

  validates_presence_of :ica_presents_begins, :program, :about, message: 'Can not be empty'
end
