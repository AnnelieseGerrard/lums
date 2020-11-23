class CreateExercises < ActiveRecord::Migration[6.0]
  def change
    create_table :exercises do |t|
      t.string :name, null: false
      t.text :rich_description, null: false
      t.boolean :is_assessed, null: false, default: false
      t.references :lecture, null: false, foreign_key: true

      t.timestamps
    end
  end
end
