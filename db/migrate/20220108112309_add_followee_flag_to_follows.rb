class AddFolloweeFlagToFollows < ActiveRecord::Migration[6.1]
  def change
    add_column :follows, :followee_flag, :boolean
  end
end
