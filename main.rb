require("./Rooms.rb")
require("./attacksystem.rb")
<<<<<<< Updated upstream
require("./save_game.rb")
=======
require("./movement.rb")
require("./save.rb")

>>>>>>> Stashed changes

$player_coordinates = [0, 2]
$coins = 3
$inventory = ["#{$coins} coins", "rusty dagger"]
$possible_actions = []

#Map kordinater map[row][col]
$map = [
    ["path", "path", "entrance", "path", "path", nil],
    ["path", "room1", "path", "room2", "path", nil],
    ["path", "room3", "path", "room4", "path", nil],
    ["room5", "empty", "path", "room6", "path", nil],
    ["room7", "path", "path", "empty", "room8", nil]
]

def fancy_text(text)
    i =0
    while i <= text.length
        sleep(rand(0.005..0.05))
        print text[i]
        i +=1
    end
    puts "\n"
end

def chest(room)
    if room == "room1"
        $coins += 3
        $inventory << "steel sword"
        fancy_text "You open the chest and find 3 gold coins and a steel sword, which have now been added to your inventory."
    end

    possibleitems = ["potion", "enchanted spear", "sword", "3 gold coins"]
    random_item = ""
    if room[0].include?("chest") && room != "room1"
        random_item = possibleitems[rand(0..3)]
        fancy_text "you open the chest and find #{random_item}"
        if random_item == "3 gold coins"
            $coins += 3
        else
            $inventory.append(random_item)
        end
    end
end

def intro()
    fancy_text("Hello #{$name} Type your actions with 3-word prompts.
You are at the opening of a cave, all you have is an old dagger and three gold coins.
Type 'inventory' to view your items, and write your actions with the verb first and maximum 3 words.")
end

#läser upp info om spelarens omgivning
def current_room()
    $player_room = $map[$player_coordinates[0]][$player_coordinates[1]]

    #innehåller rummen omkring spelaren i ordning [vänster, ner, höger]
    surrounding_rooms = [$map[$player_coordinates[0]][$player_coordinates[1] - 1], $map[$player_coordinates[0] + 1][$player_coordinates[1]], $map[$player_coordinates[0]][$player_coordinates[1] + 1]]


    if $player_room == "entrance"
        fancy_text("You have 3 corridors around you, one straight forward and one on either side of you. Which way do you go?")

    elsif $player_room == "path"
        $possible_actions = ["left", "right", "forward", "back", "open", "walk", "go"]
        if $player_coordinates == [1,2]
            fancy_text "As you walk down the corridor you encounter two doors on either side, while the corridor keeps going. The doors appear to be unlocked."
        elsif $player_coordinates == [2,2]
            fancy_text "Further down the dark tunnel you see another set of doors, same as the last ones."
        elsif $player_coordinates == [3,2]
            fancy_text "You keep walking even further down the tunnel when you see yet another door, this one only on \nyour left side. This time the door has a rusty lock."
        elsif $player_coordinates == [4,2]
            fancy_text "Now the corridor turns sharply to your right, and in the light of your \nlantern it seems to go on for a long distance ahead."
        elsif $player_coordinates == [0,0]
            fancy_text "After a few minutes of walking through the tunnel to your right, "
        end

    elsif $player_room.include?("room")
        fancy_text(rooms($player_room)[0])
        if rooms($player_room)[2] != nil
            combat($player_room)
        end
    end


end

#Ska uppdatera olika variabler som inventory och coordinater baserat på användarens input
def action(action)
    valid_input = false


    while valid_input == false
        if action[0] == "inventory"
            i = 0
            puts "In your inventory you have:"
            puts ""
            while i < $inventory.length
                puts $inventory[i]
                i += 1
            end
            puts ""

            user_prompt = gets.chomp.downcase.split
            action(user_prompt)
            break
        end

        if action[0] == "save"
            save_game("#{$name}.txt")
            exit
        end

        if $player_room == "path" || $player_room == "entrance"
            if action[0] != "open"
                if action[0] == "forward" || action[1] == "forward"
                    if $map[$player_coordinates[0] + 1][$player_coordinates[1]] != "path" && $map[$player_coordinates[0] + 1][$player_coordinates[1]] != "entrance"
                        valid_input = false
                        puts "There is no way forward, choose another path"
                        action = gets.chomp.downcase.split
                    else
                        valid_input = true
                        $player_coordinates[0] += 1
                    end

                elsif action[0] == "left" || action[1] == "left"
                    if $map[$player_coordinates[0]][$player_coordinates[1] + 1] != "path" && $map[$player_coordinates[0]][$player_coordinates[1] + 1] != "entrance"#spelarens vänster är höger på kartan, så måste öka x-värdet
                        valid_input = false
                        puts "There is no path to your left, choose another way"
                        action = gets.chomp.downcase.split
                    else
                        valid_input = true
                        $player_coordinates[1] += 1
                    end

                elsif action[0] == "right" || action[1] == "right"
                    if $map[$player_coordinates[0]][$player_coordinates[1] - 1] != "path" && $map[$player_coordinates[0]][$player_coordinates[1] - 1] != "entrance"
                        valid_input = false
                        puts "There is no path to your right, choose another way"
                        action = gets.chomp.downcase.split
                    else
                        valid_input = true
                        $player_coordinates[1] -= 1
                    end

                elsif action[0] == "back" || action[1] == "back"
                    if $map[$player_coordinates[0] - 1][$player_coordinates[1]] != "path" && $map[$player_coordinates[0] - 1][$player_coordinates[1]] != "entrance"
                        valid_input = false
                        fancy_text "There is no path behind you, choose another way"
                        action = gets.chomp.downcase.split
                    else
                        valid_input = true
                        $player_coordinates[0] -= 1
                    end
                else
                    valid_input = false
                    fancy_text "That's not a valid action, maybe you misspelled? Try again"
                    action = gets.chomp.downcase.split
                end


            else
                if action.include?("right")
                    if $map[$player_coordinates[0]][$player_coordinates[1] - 1].include?("room")
                        valid_input = true
                        $player_coordinates[1] -= 1
                    end
                elsif action.include?("left")
                    if $map[$player_coordinates[0]][$player_coordinates[1] + 1].include?("room")
                        valid_input = true
                        $player_coordinates[1] += 1
                    end
                elsif action.include?("forward")
                    if $map[$player_coordinates[0] + 1][$player_coordinates[1]].include?("room")
                        valid_input = true
                        $player_coordinates[0] += 1
                    end
                end
            end

        elsif $player_room.include?("room")
            #Before action is done, look at room and second index(aka index 1)
            #and check if action is in the possible actions.
            $possible_actions = rooms($player_room)[1]
            if $possible_actions.include?(action[0])
                valid_input = true

                if $player_room == "room1"
                    if action[0] == "exit" || action[0] == "leave" #******* VIKTIGT ********
                        $player_coordinates[1] += 1 #OM DET FINNS EN FIENDE I RUMMET SKA MAN INTE FÅ LÄMNA SÅ LÄNGE DEN LEVER

                    elsif action[0] + action[1] == "open" + "chest"
                        chest($player_room)
                        #call action function again
                    end

                elsif $player_room == "room2"
                    if action[0] == "exit" || action[0] == "leave"
                        $player_coordinates[1] -= 1

                    elsif action[0] + action[1] == "look" + "at" || action[0] == "inspect"
                        if action[1] == "painting" || action[2] == "painting"
                            fancy_text "The painting is old and worn. It depicts a majestic dragon sleeping on a mountain of gold and treasures"
                        elsif action[1] == "key" || action[2] == "key"
                            fancy_text "The key is heavy and is covered in rust in some areas"
                        end

                        user_prompt = gets.chomp.downcase.split
                        action(user_prompt)
                    elsif action[0] == "pick" || action[0] == "take"
                        if action[1] == "key"
                            $inventory << "Old key"
                            #$room2[1].delete_at($room2[1].index("pick"))
                            #$room2[1].delete_at($room2[1].index("take"))
                            fancy_text "Old key acquired"

                            user_prompt = gets.chomp.downcase.split
                            action(user_prompt)
                        elsif action[1] == "painting"
                            $inventory << "Dragon painting"
                            fancy_text "Painting acquired"

                            user_prompt = gets.chomp.downcase.split
                            action(user_prompt)
                        end
                    end
                elsif $player_room == randomrum
                    if action[0] == "exit" || action[0] == "leave"
                        $player_coordinates[1] += 1
                    end
                elsif $player_room == randomrum
                    if action[0] == "exit" || action[0] == "leave"
                        $player_coordinates[1] -= 1
                    end
                end

            else
                fancy_text "Invalid action, maybe you spelled wrong? Try again"
                user_prompt = gets.chomp.downcase.split
                action(user_prompt)
            end
        end
    end


end

def menu() 
    menu = true 

    while menu == true 
        fancy_text("1, NEW GAME")
        fancy_text("2, LOAD GAME")
        fancy_text("3, RULES")
        fancy_text("4, QUIT GAME\n")

        choice = gets.chomp 

        if choice == "1"
            save_game("saved_game.txt")  # Save the current game
            fancy_text("What is your name? ")
            $name = gets.chomp 
            menu = false  
        elsif choice == "2"
            load_game("saved_game.txt")  # Load the saved game
            fancy_text("Welcome back, #{$name}!\n")
            current_room()  # Show current room
            action()  # Prompt for player action
            menu = false
        elsif choice == "3"  
            fancy_text("You have to survive this maze. There is a room that allows you to escape and win\n")
            menu()
        elsif choice == "4"
            exit
        else 
            fancy_text("You have to choose between 1, 2, 3, or 4")
            menu()
        end 
    end 
end


def main()
<<<<<<< Updated upstream
    # Load game state from file if it exists 
    load_game("saved_game.txt")
    #intro()
    $player_coordinates = [0, 2] #entrance-rummets koordinater
=======

    menu()
    intro()
    $p_pos = [0, 2] #entrance-rummets koordinater
>>>>>>> Stashed changes
    restart_game = false

    while restart_game == false
        current_room()
        user_prompt = gets.chomp.downcase.split

        #Save game if the player wants to save 
        if user_prompt[0] == "save"
            save_game("saved_game.txt")
            next 
        end

        action(user_prompt)
    end
end

main()
