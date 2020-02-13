class User < ActiveRecord::Base
    has_many :playlists
    


    def welcome
        puts "Welcome to Shelf"
    end

    def listener
        prompt = TTY::Prompt.new
        choice = prompt.ask("New user? (y/n)")

        case choice
        when "y"
        p "Please select a username"
            new_name = gets.chomp
            listener_create = User.create(name: new_name)
        when "n"
            existing_user = User.all
            prompt.select("Who is listening?", existing_user)
        end
    end

    def menu
        prompt = TTY::Prompt.new 
    end 

    def create_playlist
        p "What do you want to call this playlist?"
            playlist_name = gets.chomp
        p 
    end

    def edit_playlist
    end

    def delete_playlist
    end

    def find_user_id
    end

end