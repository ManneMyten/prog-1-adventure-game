require("./Vector.rb")
require("./Rooms.rb")
require("./attacksystem.rb")
require("./movement.rb")

def save_game(filename)
    game_state = "Name: #{$name}\n"
    game_state = "Coins: #{$coins}\n"
    game_state += "Inventory: #{$inventory.join(", ")}\n"
    game_state += "Player Position: #{$p_pos.join(", ")}\n"

    File.open(filename, "w") do |file|
        file.write(game_state)
    end

    puts "Game saved!"
end

def load_game(filename)
    if File.exist?(filename)
        File.open(filename, "r") do |file|
            file.each_line do |line|
                if line.start_with?("Name:")
                    $name = line.split(": ")[1].chomp
                elsif line.start_with?("Coins:")
                    $coins = line.split(": ")[1].to_i
                elsif line.start_with?("Inventory:")
                    $inventory = line.split(": ")[1].split(", ")
                elsif line.start_with?("Player Position:")
                    $p_pos = line.split(": ")[1].split(", ").map(&:to_i)
                end
            end
        end
    else
        puts "Game loaded!"
    end
end