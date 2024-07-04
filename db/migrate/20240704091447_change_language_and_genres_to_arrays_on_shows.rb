class ChangeLanguageAndGenresToArraysOnShows < ActiveRecord::Migration[7.1]
  def change
    remove_column :shows, :language
    add_column :shows, :languages, :string, array: true, default: []
    remove_column :shows, :genre
    add_column :shows, :genres, :string, array: true, default: []
  end
end
