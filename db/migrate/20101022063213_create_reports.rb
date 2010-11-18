class CreateReports < ActiveRecord::Migration
  def self.up
    create_table :reports do |t|
      t.string :report_name
      t.text :report_content
      t.integer :report_template_id

      t.timestamps
    end
  end

  def self.down
    drop_table :reports
  end
end
