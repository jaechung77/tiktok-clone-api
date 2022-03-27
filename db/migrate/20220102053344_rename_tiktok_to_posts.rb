class RenameTiktokToPosts < ActiveRecord::Migration[6.1]
  def change
    rename_column :posts, :tiktok_file, :image
  end
end
