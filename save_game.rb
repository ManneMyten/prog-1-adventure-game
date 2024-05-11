require("./main.rb")

def save_game(file_name)
    File.open(file_name, "w") do |file|
        file.puts $player_coordinates.join(",")
        file.puts $coins
        file.puts $inventory.join(",")
    end
    puts "Game saved successfully."
end

def load_game(file_name)
    if File.exist?(file_name)
        File.open(file_name, "r") do |file|
            $player_coordinates = file.readline.chomp.split(",").map(&:to_i)
            $coins = file.readline.chomp.to_i
            $inventory = file.readline.chomp.split(",")
        end
        puts "Game loaded usccessfylly."
    else
        puts "No saved game found."
    end
end
