require_relative '../config/environment'
require "pry"

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
        existing_users = User.all.each do |teacher|
            puts User.name
        end
        prompt.select("Who is listening?", existing_users)
    end
end

welcome
listener

puts 'What would you like to do?'

puts '1. Listen'
puts '2. Create Playlist'
puts '3. Edit Playlist'
puts '4. Delete Playlist'
puts '5. Exit'
binding.pry


