class Song < ActiveRecord::Base
    has_many :Songplaylists
    has_many :songs, through: :Songplaylists
end

def add_song
    p "Song Name?"
    name_of_song = gets.chomp
    p "Song Artist?"
    song_artist = gets.chomp
    p "Song Genre?"
    song_genre = gets.chomp
    p "Platform?"
    platform = gets.chomp

    song_added = Song.create(name: name_of_song, artist: song_artist, genre: song_genre, )
end

def remove_song(name:)

end