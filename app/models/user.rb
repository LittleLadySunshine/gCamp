class User < ActiveRecord::Base

  # validates :email, presence: true, uniqueness: true, case_sensitive: false
  validates_presence_of :first_name, :last_name, :email
  has_secure_password

end
