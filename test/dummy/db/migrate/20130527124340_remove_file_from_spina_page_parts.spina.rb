# This migration comes from spina (originally 20130527124130)
class RemoveFileFromSpinaPageParts < ActiveRecord::Migration
  def up
    remove_column :spina_page_parts, :file_id
  end

  def down
    add_column :spina_page_parts, :file_id, :integer
  end
end
