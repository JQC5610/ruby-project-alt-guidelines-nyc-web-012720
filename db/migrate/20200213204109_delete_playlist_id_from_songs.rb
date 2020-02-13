class DeletePlaylistIdFromSongs < ActiveRecord::Migration[5.2]
  def change
    remove_column :songs, :playlist_id
  end
end
