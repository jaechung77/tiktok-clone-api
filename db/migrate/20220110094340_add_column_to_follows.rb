class AddColumnToFollows < ActiveRecord::Migration[6.1]
  def change
    add_column :follows, :followee_nick_name, :string
    add_column :follows, :follower_nick_name, :string
  end
end
