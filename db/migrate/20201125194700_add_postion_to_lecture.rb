class AddPostionToLecture < ActiveRecord::Migration[6.0]
  def change
    add_column :lectures, :position, :integer
  end
end
