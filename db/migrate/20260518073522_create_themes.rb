class CreateThemes < ActiveRecord::Migration[8.1]
  def change
    create_table :themes do |t|
      t.string :name
      t.text :specs
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
