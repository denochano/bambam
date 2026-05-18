class CreateElements < ActiveRecord::Migration[8.1]
  def change
    create_table :elements do |t|
      t.string :name
      t.text :html_code
      t.text :css_code
      t.references :theme, null: false, foreign_key: true

      t.timestamps
    end
  end
end
