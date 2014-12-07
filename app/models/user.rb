class User < ActiveRecord::Base

  validates :email, presence: true, uniqueness: true, case_sensitive: false
  validates_presence_of :first_name, :last_name, :email


  has_secure_password
  has_many :memberships, dependent: :delete_all
  has_many :projects, through: :memberships
  has_many :tasks, through: :comments
  has_many :comments, dependent: :nullify

  def full_name
    "#{first_name} #{last_name}"
  end



end
