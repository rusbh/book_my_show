class AddSlugToTheaters < ActiveRecord::Migration[7.1]
  def change
    add_column :theaters, :slug, :string
    add_index :theaters, :slug, unique: true
  end
end
