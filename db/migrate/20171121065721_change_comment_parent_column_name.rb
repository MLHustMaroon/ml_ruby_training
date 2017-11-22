class ChangeCommentParentColumnName < ActiveRecord::Migration[5.1]
  def change
    rename_column :comments, :parent, :parent_id
  end
end
