class User < ActiveRecord::Base
    has_many :playlists
    has_many :songs, through: :playlists 
    
    @@prompt = TTY::Prompt.new #so i can call tty promt in any of my methods in this class

    def create_playlist
        playlist_name = @@prompt.ask("What do you want to call this playlist?") do |q| 
            q.required true #requires user input
            q.modify :trim #removes whitespace
        end
        # puts "What do you want to call this playlist?"
        # playlist_name = gets.chomp.strip
        new_playlist = Playlist.create(name: playlist_name, user_id: self.id)
        # self.add_song_to_playlist(new_playlist.id) 
    end

    def add_song_to_playlist#(p_id)
        choices = Song.all.map{|song| "#{song.id}. #{song.name}"}
        user_song_picks = @@prompt.multi_select("Select songs", choices)
        songs_by_id = user_song_picks.map{|song|song.to_i}
        songs_by_id.each{|id|SongPlaylist.create(song_id: id, playlist_id: Playlist.all.last.id)}

        # user_song_picks.each |

    end

    def view_playlists
        p_id = get_playlist_id("Which playlist do you want to view?")
        playlist = self.playlists.find_by(id: p_id) #user playlists
        playlist.songs.each {|song| puts "#{song.name}"}
        # self.playlists.each {|playlist| puts "#{playlist.name}"} 
    end

    def delete_song_from_playlist
    
        p_id = get_playlist_id("What playlist do you want to delete from?") #this method receives user input of what playlist they want to edit and stores it into a variable in this method
        playlist = self.playlists.find_by(id: p_id) #user playlists
        songs_in_playlist = playlist.songs
        
        s_id = get_song_id("Which song do you want to remove?", songs_in_playlist)
        sp = SongPlaylist.find_by(song_id: s_id, playlist_id: p_id)
        sp.destroy
    end

    def add_song_to_existing_playlist
        p_id = get_playlist_id("What playlist do you want to add to?")
        playlist = self.playlists.find_by(id: p_id)
        s_id = get_song_id("What song do you want to add?", Song.all)
        SongPlaylist.create(song_id: s_id, playlist_id: p_id)
    end

    def delete_a_playlist
        p_id = get_playlist_id("What playlist do you want to delete?")
        # Playlist.destroy_all(id: p_id)
       
        playlist = self.playlists.find_by(id: p_id)
        playlist.destroy
    end

    ### Helper Methods

    def get_playlist_id(prompt)
        playlist_id = @@prompt.select(prompt) do |menu|
            self.playlists.each do |playlist| 
                menu.choice playlist.name, playlist.id
            end
        end
        playlist_id
    end


    def get_song_id(prompt, songs)
        song_id = @@prompt.select(prompt) do |menu|
            songs.each do |song|
                menu.choice song.name, song.id
            end
        end 
    end


  
end