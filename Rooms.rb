$room3 = []
$room4 = []
$room1 = ["You enter the door to your right to find a dimly lit room with a chest in the center.", ["open", "exit"]]
$room5 = ["Opening the oak door you find, to your surprise, an old man standing behind a desk. \n Would you like to buy something? he utters while smiling warmly. \n what will you do?", ["open", "walk", "exit", "leave", "buy", "talk"]]
$room2 = ["Entering the room you see a table with a rusty old key on it.\n You also notice a painting hung upon the cobble wall", ["attack", "walk", "exit", "leave", "look", "inspect", "pick", "take"]]

def rooms(room)

    #first index = description, second index is possible actions
    rand_room_1 = ["As you walk into the room you are met with a chest positioned upon an intricately designed stone stand,\nbut the ominous feeling of a presence in the dark alerts you. A giant spider suddenly appears before you falling from the ceiling!\nWhat do you do?", ["open", "exit", "leave", "attack", "walk"]]

    rand_room_2 = ["Upon entering the room you notice the faint glowing of a torch,\n you quickly notice the skeleton holding the torch and a sword.What will you do?", ["walk", "exit", "leave", "attack"]]

    #array of randomized rooms.
    roomlist = [rand_room_1, rand_room_2]

    if room == "room1"
        return $room1

    elsif room == "room5"
        return $room5

    elsif room == "room2"
        return $room2

    elsif room == "room3" && $room3 != []
        return $room3

    elsif room == "room4" && $room4 != []
        return $room4

    elsif room == "room3" || room == "room4"
        randomnum = rand(0..(roomlist.length - 1))
        assignedroom = roomlist[randomnum]
        roomlist.delete_at(randomnum)

        if room == "room3"
            $room3 = assignedroom
            $room4 =  roomlist[0]
            return $room3
        elsif room == "room4"
            $room4 = assignedroom
            $room3 = roomlist[0]
            return $room4
        end
    end
end
