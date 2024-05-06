$room1 = ["You enter the door to your right to find a dimly lit room with a chest in the center.", ["open", "exit", "leave"]]
$room2 = ["Entering the room you see a table with a rusty old key on it.\nYou also notice a painting hung upon the cobble wall", ["walk", "exit", "leave", "look", "inspect", "pick", "take"]]
$room3 = []
$room4 = []
$room5 = ["Opening the oak door you find, to your surprise, an old man standing behind a desk. \nWould you like to buy something? he utters while smiling warmly. \nWhat will you do?", ["open", "walk", "exit", "leave", "buy", "talk"]]
$room6 = []
$room7 = []
$room8 = ["You have found the big red Ruby. You are now the crown winner of NTI Kronhus"]
#first index = description, second index is possible actions
rand_room_1 = ["As you walk into the room you are met with a chest positioned upon an intricately designed stone stand,\nbut the ominous feeling of a presence in the dark alerts you.\nA giant spider suddenly appears before you falling from the ceiling!\nWhat do you do?", ["open", "exit", "leave", "attack", "walk"]]
rand_room_2 = ["Upon entering the room you notice the faint glowing of a torch,\nyou quickly notice the skeleton holding the torch and a sword.What will you do?", ["walk", "exit", "leave", "attack"]]
rand_room_3 = ["You have found a healing potion. What will you do?", ["open", "exit", "leave", "attack", "walk"]]
rand_room_4 = ["There is a open chest with 5 healing potions, is your luck unbelievable or does somethin seem sketchy?. What will you do?", ["walk", "exit", "leave", "attack"]]

#array of randomized rooms.
$roomlist = [rand_room_1, rand_room_2, rand_room_3, rand_room_4]

def rooms(room)


    if room == "room1"
        return $room1

    elsif room == "room2"
        return $room2

    elsif room == "room5"
        return $room5

    elsif room == "room3" && $room3 != []
        return $room3

    elsif room == "room4" && $room4 != []
        return $room4

    elsif room == "room3" || room == "room4" || room == "room5" || room == "room6"
        randomnum = rand(0..($roomlist.length - 1))
        assignedroom = $roomlist[randomnum]
        $roomlist.delete_at(randomnum)

        if room == "room3"
            $room3 = assignedroom
            return $room3
        elsif room == "room4"
            $room4 = assignedroom
            return $room4
        elsif room == "room6"
            $room6 = assignedroom
            return $room6
        elsif room == "room7"
            $room7 = assignedroom
            return $room7
        end
    end
end
