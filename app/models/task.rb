class Task < ActiveRecord::Base

  belongs_to :project

  validates :description, presence: true


  validate :due_date_valid

  def due_date_valid
    if due_date.present? && due_date < due_date.current && !id.present?
      errors.add(:due_date, "must be present or future")
    end
  end

end
