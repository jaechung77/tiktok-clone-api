class CreateFollows < ActiveRecord::Migration[6.1]
  def change
    create_table :follows do |t|
      t.integer :followee_id
      t.integer :follower_id
      t.boolean :accept_flag

      t.timestamps
    end
  end
end
