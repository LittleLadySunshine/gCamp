class User < ActiveRecord::Base

  # validates :email, presence: true, uniqueness: true, case_sensitive: false

  validates_presence_of :first_name, :last_name, :email
  has_secure_password
  has_many :memberships, dependent: :destroy
  has_many :projects, through: :memberships

  def full_name
    "#{first_name} #{last_name}"
  end



end
