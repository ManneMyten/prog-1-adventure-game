$player_coordinates = [0, 2]

#Map kordinater map[row][col]
map = [
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

def current_room()
    $player_room = map[$player_coordinates[0]][$player_coordinates[1]]

    if $player_room == "entrance"
        puts "You have 3 corridors around you, one straight forward and one on either side of you. Which way do you go?"
    end


end

def action(action) #Ska uppdatera olika variabler som inventory och coordinater baserat på användarens input
    
    
    if $player_room == "entrance"
        allowed_actions = ["right", "left", "forward"]
    elsif $player_room ==
        
    end
    #Add validation of input

    if 
end

def main()
    # intro()
    $player_coordinates = [0, 2]

    current_room()
    user_prompt = gets.chomp.split

    action(user_prompt)
    

end
