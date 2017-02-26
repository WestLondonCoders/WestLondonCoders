class RenameJobTitleToTagline < ActiveRecord::Migration
  def change
    rename_column :users, :job_title, :tagline
  end
end
