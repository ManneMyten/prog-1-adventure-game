def rooms(room)
    room1 = ["You enter the door to your right to find a dimly lit room with a chest in the center.", ["open", "exit"]]

    #first index = description, second index is possible actions
    rand_room_1 = ["As you walk into the room you are met with a chest positioned upon an intricately designed stone stand,\nbut the ominous feeling of a presence in the dark alerts you. A giant spider suddenly appears before you falling from the ceiling!\nWhat do you do?", ["open", "attack", "walk"]]

    rand_room_2 = ["Upon entering the room you notice the faint glowing of a torch, you quickly notice the skeleton holding the torch and a sword.
What will you do?", ["walk", "attack"]]

    #array of randomized rooms.
    roomlist = [rand_room1, rand_room_2]

    if room == "room1"
        return room1
    elsif room == "room3" || room == "room4"
        return roomlist(rand(0..1))
    end
end