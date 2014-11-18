class Registration < ActiveRecord::Base

  validates :first_name, presence: true, :last_name, presence: true
   :email, presence: true, uniqueness: { case_sensitive: false }
  has_secure_password

end
