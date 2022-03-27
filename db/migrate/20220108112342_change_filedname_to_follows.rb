class ChangeFilednameToFollows < ActiveRecord::Migration[6.1]
  def change
    rename_column :follows, :accept_flag, :follower_flag
  end
end
