class DeleteColumnToFollows < ActiveRecord::Migration[6.1]
  def change
    remove_column  :follows, :follower_flag
    remove_column  :follows, :followee_flag    
  end
end
