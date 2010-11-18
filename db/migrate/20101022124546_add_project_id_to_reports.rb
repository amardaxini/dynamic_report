class AddProjectIdToReports < ActiveRecord::Migration
  def self.up
    add_column :reports, :project_id, :integer
  end

  def self.down
    remove_column :reports, :project_id
  end
end
