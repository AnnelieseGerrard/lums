class AddIsCreatorFieldToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :is_creator, :boolean
  end
end
