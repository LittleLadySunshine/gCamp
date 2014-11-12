class Task < ActiveRecord::Base
  validates :description, presence: true

  validate :not_past_date

  def not_past_date
    if due_date.present? && due_date < Date.today
      errors.add(:due_date, "cannnot be in the past")
    end
  end

end
