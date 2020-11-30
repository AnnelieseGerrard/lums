class RemoveNullFromRichDescriptionInExercises < ActiveRecord::Migration[6.0]
  def change
    change_column_null :exercises, :rich_description, true
  end
end
