class CreateReportTemplates < ActiveRecord::Migration
  def self.up
    create_table :report_templates do |t|
      t.string :template_name
      t.text :template_content

      t.timestamps
    end
  end

  def self.down
    drop_table :report_templates
  end
end
