class Teacher < OmniAuth::Identity::Models::ActiveRecord
  has_many :projects, as: :author, dependent: :destroy
  has_many :messages, dependent: :destroy

  def admin?
    true
  end
end
