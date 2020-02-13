class CreateSongTable < ActiveRecord::Migration[5.2]
  def change
    create_table :songs do |t|
      t.string :name
      t.string :artist
      t.string :genre
      t.string :platform
      t.integer :playlist_id
    end
  end
end
