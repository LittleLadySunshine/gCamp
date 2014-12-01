class Task < ActiveRecord::Base

  validates :description, presence: true
  validate :due_date_cannot_be_in_the_past, on: :create
  validates_inclusion_of  :date, {:on => :create, :in =>  (Date.today)..(Date.today + 20.years), :allow_nil => true}
  belongs_to :project
  has_many :users
  has_many :comments, dependent: :destroy

end
