class CreateTasks < ActiveRecord::Migration
  def change
    create_column :tasks do |t|
      t.string :description


    end
end
