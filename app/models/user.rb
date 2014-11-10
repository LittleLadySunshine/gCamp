class User < ActiveRecord::Base

  validates :email, presence: true, uniqueness: true, case_sensitive: false
  has_secure_password

end
