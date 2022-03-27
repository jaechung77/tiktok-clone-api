class AddFieldToFollows < ActiveRecord::Migration[6.1]
  def change
    add_column :follows, :status, :integer
  end
end
