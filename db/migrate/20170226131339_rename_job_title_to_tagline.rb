class RenameJobTitleToTagline < ActiveRecord::Migration[4.2]
  def change
    rename_column :users, :job_title, :tagline
  end
end
