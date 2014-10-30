class Project < ActiveRecord::Migration
  def change
        create_table :projects do |p|
          p.string :name
        end
  end
end
