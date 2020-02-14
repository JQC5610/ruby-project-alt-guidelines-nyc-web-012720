require_relative '../config/environment'
require "pry"

class CommandLineInterface
    attr_accessor :signed_in

    def initialize
        @@prompt = TTY::Prompt.new #access global variable of TTY:Prompt
    end


    def welcome
        choice = @@prompt.select("Welcome to Shelf\nNew user?") do |menu| #able to use @@prompt bc global var initialized with every instance 
            menu.choice 'Yes', 'y'
            menu.choice 'No', 'n'
        end
        case choice
        when 'y'
                create_new
        when 'n'
                select_existing
        end
    end

    def create_new
        p "Username?"
        new_name = gets.chomp.strip

        user = User.create(name: new_name)

        @signed_in = true
        while @signed_in
            menu(user)
        end
        
    end
    
    
    def select_existing
        
        # current_users = existing_users.map{|user| user.name}
        username = @@prompt.ask("Who is listening?") do |q|
            q.required true
            q.modify :trim
        end          #displays existing users
        
        user = User.find_by(name: username)

        if user
            @signed_in = true
            while @signed_in
                menu(user)
            end
        else
            puts "User does not exist. Please try again"
        end
        
    end
    
    def menu(user)
        choice = @@prompt.select("What would you like to do?") do |menu|
            menu.choice '1. Create Playlist', 1
            menu.choice '2. View Playlist', 2
            menu.choice '3. Add To Existing Playlist', 3
            menu.choice '4. Delete Songs From Existing Playlist', 4
            menu.choice '5. Delete A Playlist', 5
            menu.choice '6. Exit', 6
        end
            case choice
            when 1 
                user.create_playlist
                # p "What songs would you like to add?"
                # show_all_songs
                user.add_song_to_playlist
            when 2
                user.reload.view_playlists #updates DB in real time
            when 3
                user.add_song_to_existing_playlist
            when 4
                user.delete_song_from_playlist
            when 5
              
            when 6
                p "Goodbye"
                @signed_in = false
            end

        
    end
    

end


