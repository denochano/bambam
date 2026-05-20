class AddAttributesToMessages < ActiveRecord::Migration[8.1]
  def change
    add_column :messages, :css_code, :text
    add_column :messages, :html_code, :text
  end
end
