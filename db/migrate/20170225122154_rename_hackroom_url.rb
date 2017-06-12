class RenameHackroomUrl < ActiveRecord::Migration[4.2]
  def change
    rename_column :hackrooms, :url, :project_url
  end
end
