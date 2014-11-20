class CommentsTable < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :task_id
      t.integer :user_id
      t.string :text
    end
  end
end
