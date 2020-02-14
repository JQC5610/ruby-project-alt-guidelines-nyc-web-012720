class Playlist < ActiveRecord::Base
    belongs_to :users
    has_many :song_playlists
    has_many :songs, through: :song_playlists
end



