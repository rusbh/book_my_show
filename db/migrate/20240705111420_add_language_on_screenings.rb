class AddLanguageOnScreenings < ActiveRecord::Migration[7.1]
  def change
    add_column :screenings, :language, :string
  end
end
