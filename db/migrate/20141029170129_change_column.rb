class ChangeColumn < ActiveRecord::Migration
  def change
    change_column :tasks, :complete, :boolean, :null =>false, :default=>false
  end
end
