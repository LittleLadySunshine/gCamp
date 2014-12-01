ActiveRecord::Schema.define(version: 20141125221311) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: true do |t|
    t.text     "description"
    t.integer  "user_id"
    t.integer  "task_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "memberships", force: true do |t|
    t.integer "user_id"
    t.integer "project_id"
    t.string  "role"
  end

  create_table "projects", force: true do |t|
    t.string "name"
  end

  create_table "tasks", force: true do |t|
    t.string  "description"
    t.boolean "complete",    default: false, null: false
    t.date    "due_date"
    t.integer "project_id"
  end

  create_table "users", force: true do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "password_digest"
  end

end
