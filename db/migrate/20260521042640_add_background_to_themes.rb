class AddBackgroundToThemes < ActiveRecord::Migration[8.1]
  def change
    add_column :themes, :background, :string
  end
end
