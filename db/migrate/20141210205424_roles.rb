class Roles < ActiveRecord::Migration
  def change
    create_table "roles", force: true do |t|
      t.string   "role"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
  end
end
