class RemoveForeignkeyFromFollows < ActiveRecord::Migration[6.1]
  def change
    remove_foreign_key :follows, column: :followee_id
    remove_foreign_key :follows, column: :follower_id
  end
end
