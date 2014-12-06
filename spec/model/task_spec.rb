require 'rails_helper'

describe "Task" do

  it "validates presence of description and due date" do

    task = Task.new
    task.valid?
    expect(task.errors[:description].present?).to eq(true)

    task.description = "description"
    task.due_date = Date.today + 1.year
    task.valid?
    expect(task.errors[:description].present?).to eq(false)
    expect(task.errors[:due_date].present?).to eq(false)

  end

  it "doesn't allow tasks to be created with past due dates, but they can be updated with past due dates" do

    task = Task.new(
    description: "description",
    due_date: Date.today - 1.year
    )
    task.valid?
    expect(task.errors[:due_date].present?).to eq(true)

    task = Task.new(
    description: "description",
    due_date: Date.today + 1.year
    )
    task.save
    task.due_date = Date.today - 2.years
    task.valid?
    expect(task.errors[:due_date].present?).to eq(false)
  end

end
