class RenameVideoToPosts < ActiveRecord::Migration[6.1]
  def change
    rename_column :posts, :video, :file
  end
end
