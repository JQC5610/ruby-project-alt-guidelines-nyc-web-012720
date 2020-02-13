class Playlist < ActiveRecord::Base
    has_many :Songplaylists
    has_many :songs, through: :Songplaylists
end

def song_count
end

