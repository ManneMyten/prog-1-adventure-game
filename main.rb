require("./Vector.rb")
require("./Rooms.rb")
require("./movement.rb")


$coins = 3
$inventory = ["#{$coins} coins", "rusty dagger"]
$possible_actions = []



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

end

def intro()
    fancy_text("Type your actions with 3-word prompts.
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
    end


end

#Ska uppdatera olika variabler som inventory och coordinater baserat på användarens input
def action()
    action = gets.chomp.downcase.split
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

            action()
            break
        end

        if $player_room == "path" || $player_room == "entrance"
            if action[0] != "open"
                if action[0] == "forward" || action[1] == "forward"
                    if !move("fwd")
                        valid_input = false
                        puts "There is no way forward, choose another path"
                        action = gets.chomp.downcase.split
                        next
                    else
                        # p $player_coordinates
                        valid_input = true
                    end

                elsif action[0] == "left" || action[1] == "left"
                    if !move("left")
                        valid_input = false
                        puts "There is no way to your left, choose another path"
                        action = gets.chomp.downcase.split
                        next
                    else
                        valid_input = true
                    end

                elsif action[0] == "right" || action[1] == "right"
                    if !move("right")
                        valid_input = false
                        puts "There is no way to your right, choose another path"
                        action = gets.chomp.downcase.split
                        next
                    else
                        valid_input = true
                    end

                elsif action[0] == "back" || action[1] == "back" || action[0] == "backward" || action[1] == "backward"
                    if !move("back")
                        valid_input = false
                        puts "There is no way backwards, choose another path"
                        action = gets.chomp.downcase.split
                        next
                    else
                        valid_input = true
                    end
                else
                    valid_input = false
                    fancy_text "That's not a valid action, maybe you misspelled? Try again"
                    action = gets.chomp.downcase.split
                    next
                end


            else
                if action.include?("right")
                    if !enter_room("right")
                        valid_input = false
                        fancy_text "There is no door to your right, choose another path"
                        action = gets.chomp.downcase.split
                        next
                    else
                        valid_input = true
                    end
                elsif action.include?("left")
                    if !enter_room("left")
                        valid_input = false
                        fancy_text "There is no door to your left, choose another path"
                        action = gets.chomp.downcase.split
                        next
                    else
                        valid_input = true
                    end
                elsif action.include?("forward")
                    if !enter_room("fwd")
                        valid_input = false
                        fancy_text "There is no door ahead, choose another path"
                        action = gets.chomp.downcase.split
                        next
                    else
                        valid_input = true
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
                    if action[0] == "exit" || action[0] == "leave"
                        if !move("back")
                            p "what??"
                        end
                        
                    elsif action[0] + action[1] == "open" + "chest"
                        chest($player_room)
                        action()
                    end

                elsif $player_room == "room2"
                    if action[0] == "exit" || action[0] == "leave"
                        if !move("back")
                            p "what??"
                        end
                        
                    elsif action[0] + action[1] == "look" + "at" || action[0] == "inspect"
                        if action[1] == "painting" || action[2] == "painting"
                            fancy_text "The painting is old and worn. It depicts a majestic dragon sleeping on a mountain of gold and treasures"
                        elsif action[1] == "key" || action[2] == "key"
                            fancy_text "The key is heavy and is covered in rust in some areas"
                        end

                        
                        action()
                    elsif action[0] == "pick" || action[0] == "take"
                        if action[1] == "key"
                            $inventory << "Old key"
                            #$room2[1].delete_at($room2[1].index("pick"))
                            #$room2[1].delete_at($room2[1].index("take"))
                            fancy_text "Old key acquired"
    
                            action()
                        elsif action[1] == "painting"
                            $inventory << "Dragon painting"
                            fancy_text "Painting acquired"

                            action()
                        end
                    end
                elsif $player_room == "room3"
                    if action[0] == "exit" || action[0] == "leave"
                        $player_coordinates[1] += 1
                    end
                elsif $player_room == "room4"
                    if action[0] == "exit" || action[0] == "leave"
                        $player_coordinates[1] -= 1
                    end
                end

            else
                fancy_text "Invalid action, maybe you spelled wrong? Try again"
            end
        end
    end


end

def main()
    #intro()
    $player_coordinates = [0, 2] #entrance-rummets koordinater
    restart_game = false

    while restart_game == false
        current_room()

        action()
    end
end

main()
