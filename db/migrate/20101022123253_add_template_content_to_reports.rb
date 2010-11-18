class AddTemplateContentToReports < ActiveRecord::Migration
  def self.up
    add_column :reports, :template_content, :text
  end

  def self.down
    remove_column :reports, :template_content
  end
end
