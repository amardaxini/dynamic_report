class CreateTasks < ActiveRecord::Migration
  def self.up
    create_table :tasks do |t|
      t.string :name
      t.text :description
      t.date :start_date
      t.date :end_date
      t.integer :project_id
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :tasks
  end
end
