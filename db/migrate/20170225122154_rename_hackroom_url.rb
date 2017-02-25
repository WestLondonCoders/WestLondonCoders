class RenameHackroomUrl < ActiveRecord::Migration
  def change
    rename_column :hackrooms, :url, :project_url
  end
end
