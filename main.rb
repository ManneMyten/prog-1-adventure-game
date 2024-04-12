$player_coordinates = [0, 2]
$coins = 3
$inventory = ["#{$coins} coins", "rusty dagger"]

#Map kordinater map[row][col]
$map = [
    ["path", "path", "entrance", "path", "path"], 
    ["path", "room1", "path", "room2", "path"], 
    ["path", "room3", "path", "room4", "path"], 
    ["room5", "empty", "path", "room6", "path"], 
    ["room7", "path", "path", "empty", "room8"]
]


def intro()
    puts "welcome to the world of Dork"
    puts "type your actions with 3-word prompts"
    puts "You open your eyes and see that you are in a forest clearing, in front of a cave entrance"
end

#läser upp info om spelarens omgivning
def current_room()
    $player_room = $map[$player_coordinates[0]][$player_coordinates[1]]

    #innehåller rummen omkring spelaren i ordning [vänster, ner, höger]
    surrounding_rooms = [$map[$player_coordinates[0]][$player_coordinates[1] - 1], $map[$player_coordinates[0] + 1][$player_coordinates[1]], $map[$player_coordinates[0]][$player_coordinates[1] + 1]]


    if $player_room == "entrance"
        puts "You have 3 corridors around you, one straight forward and one on either side of you. Which way do you go?"
    
    elsif $player_room == "path"
        if $player_coordinates == [1,2]
            puts "As you walk down the corridor you encounter two doors on either side, while the corridor keeps going. The doors appear to be unlocked."
        elsif $player_coordinates == [2,2]
            puts "Further down the dark tunnel you see another set of doors, same as the last ones."
        end

    elsif $player_room == "room1" #Spindelrum?
        puts ""
    end


end

#Ska uppdatera olika variabler som inventory och coordinater baserat på användarens input
def action(action) 
    valid_input = false
    
    
    while valid_input == false
        if action[0] == "inventory"
            i = 0
            puts "In your inventory you have:"
            while i < $inventory.length
                puts $inventory[i]
            end

            break
        end

        if $player_room == "path" || $player_room == "entrance"
            if action[0] == "forward" || action[1] == "forward"
                if $map[$player_coordinates[0] + 1][$player_coordinates[1]] != "path"
                    valid_input = false
                    puts "There is no way forward, choose another path"
                    action = gets.chomp.split
                else
                    valid_input = true
                    $player_coordinates[0] += 1
                end
                
            elsif action[0] == "left" || action[1] == "left"
                if $map[$player_coordinates[0]][$player_coordinates[1] + 1] != "path" #spelarens vänster är höger på kartan, så måste öka x-värdet
                    valid_input = false
                    puts "There is no path to your left, choose another way"
                    action = gets.chomp.split
                else
                    valid_input = true
                    $player_coordinates[1] += 1
                end

            elsif action[0] == "right" || action[1] == "right"
                if $map[$player_coordinates[0]][$player_coordinates[1] - 1] != "path" 
                    valid_input = false
                    puts "There is no path to your right, choose another way"
                    action = gets.chomp.split
                else
                    valid_input = true
                    $player_coordinates[1] -= 1
                end
            end
        elsif $player_room == "room1"

        end
    end

    
end

def main()
    #intro()
    $player_coordinates = [0, 2] #entrance-rummets koordinater
    restart_game = false

    while restart_game == false
        current_room()
        user_prompt = gets.chomp.split

        action(user_prompt)
    end

end


main()