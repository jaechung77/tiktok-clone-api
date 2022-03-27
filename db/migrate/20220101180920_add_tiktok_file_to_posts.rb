class AddTiktokFileToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :tiktok_file, :string
  end
end
