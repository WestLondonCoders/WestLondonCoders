class RemoveCkEditorTables < ActiveRecord::Migration[5.1]
  def change
    drop_table :post_attachments
    drop_table :ckeditor_assets
  end
end
