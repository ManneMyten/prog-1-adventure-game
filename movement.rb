#Map koordinater map[row][col]
$map = [
    ["path", "path", "entrance", "path", "path", nil],
    ["path", "room1", "path", "room2", "path", nil],
    ["path", "room3", "path", "room4", "path", nil],
    ["room5", "empty", "path", "room6", "path", nil],
    ["room7", "path", "path", "empty", "room8", nil],
    [   nil,    nil,    nil,    nil,    nil,    nil]
]

$map_walls = [
    ["path", "path", "entrance", "path", "path", "empty"],
    ["path", "room1r", "path", "room2l", "path", "empty"],
    ["path", "room3r", "path", "room4l", "path", "empty"],
    ["room5u", "empty", "path", "room6l", "path", "empty"],
    ["room7r", "path", "path", "empty", "room8u", "empty"],
    ["empty", "empty", "empty", "empty", "empty", "empty"]
]

$p_pos = [0, 2]
$p_direction = [1, 0]

def rotate_vector(vec, angle)
    rad = angle * Math::PI / 180
    x = vec[0] * Math.cos(rad) - vec[1] * Math.sin(rad)
    y = vec[0] * Math.sin(rad) + vec[1] * Math.cos(rad)

    return [x.to_i, y.to_i]
end

def collision(direction)
    if direction == "right"
        $p_direction = rotate_vector($p_direction, -90)
    elsif direction == "left"
        $p_direction = rotate_vector($p_direction, 90)
    elsif direction == "back"
        $p_direction = rotate_vector($p_direction, 180)
    end

    if $map[$p_pos[0] + $p_direction[0]][$p_pos[1] + $p_direction[1]] != "path" && $map[$p_pos[0] + $p_direction[0]][$p_pos[1] + $p_direction[1]] != "entrance"
        if direction == "right"
            $p_direction = rotate_vector($p_direction, 90)
        elsif direction == "left"
            $p_direction = rotate_vector($p_direction, -90)
        elsif direction == "back"
            $p_direction = rotate_vector($p_direction, 180)
        end
        return false
    else
        return true
    end
end

def move(direction)

    if collision(direction)
        $p_pos[0] += $p_direction[0]
        $p_pos[1] += $p_direction[1]
        # p $p_direction
        # p $p_pos
        return true
    else
        return false
    end

end

def enter_room(direction)
    if direction == "right"
        $p_direction = rotate_vector($p_direction, -90)
    elsif direction == "left"
        $p_direction = rotate_vector($p_direction, 90)
    elsif direction == "back"
        $p_direction = rotate_vector($p_direction, 180)
    end

    if !$map[$p_pos[0] + $p_direction[0]][$p_pos[1] + $p_direction[1]].include?("room")
        if direction == "right"
            $p_direction = rotate_vector($p_direction, 90)
        elsif direction == "left"
            $p_direction = rotate_vector($p_direction, -90)
        elsif direction == "back"
            $p_direction = rotate_vector($p_direction, 180)
        end
        return false
    else
        $p_pos[0] += $p_direction[0]
        $p_pos[1] += $p_direction[1]
        return true
    end
end


def path_reader()
    front_room = $map_walls[$p_pos[0] + $p_direction[0]][$p_pos[1] + $p_direction[1]]
    if front_room.include?("room")
        if $p_direction == [0,1]
            if front_room[-1] == "l"
                front_room = "a door"
            else 
                front_room = "a wall"
            end
        elsif $p_direction == [0,-1]
            if front_room[-1] == "r"
                front_room = "a door"
            else 
                front_room = "a wall"
            end
        elsif $p_direction == [1,0]
            if front_room[-1] == "u"
                front_room = "a door"
            else
                front_room = "a wall"
            end
        else 
            front_room = "a wall"
        end
    elsif front_room == "empty"
        front_room = "a wall"
    elsif front_room == "path"
        front_room = "a path" #Randomise exakt, typ "pathway" eller "tunnel"
    elsif front_room == "entrance"
        front_room = "the entrance"
    end

    right_room = $map_walls[$p_pos[0] + rotate_vector($p_direction, -90)[0]][$p_pos[1] + rotate_vector($p_direction, -90)[1]]
    if right_room.include?("room")
        if $p_direction == [0,1]
            if right_room[-1] == "u"
                right_room = "a door"
            else 
                right_room = "a wall"
            end
        elsif $p_direction == [0,-1]
            if right_room[-1] == "d"
                right_room = "a door"
            else 
                right_room = "a wall"
            end
        elsif $p_direction == [1,0]
            if right_room[-1] == "r"
                right_room = "a door"
            else
                right_room = "a wall"
            end
        elsif $p_direction == [-1,0]
            if right_room[-1] == "l"
                
                right_room = "a door"
            else
                right_room = "a wall"
            end
        end
    elsif right_room == "empty"
        right_room = "a wall"
    elsif right_room == "path"
        right_room = "a path" #Randomise exakt, typ "pathway" eller "tunnel"
    elsif right_room == "entrance"
        right_room = "the entrance"
    end

    left_room = $map_walls[$p_pos[0] + rotate_vector($p_direction, 90)[0]][$p_pos[1] + rotate_vector($p_direction, 90)[1]]
    if left_room.include?("room")
        if $p_direction == [0,1]
            if left_room[-1] == "d"
                left_room = "a door"
            else 
                left_room = "a wall"
            end
        elsif $p_direction == [0,-1]
            if left_room[-1] == "u"
                left_room = "a door"
            else 
                left_room = "a wall"
            end
        elsif $p_direction == [1,0]
            if left_room[-1] == "l"
                left_room = "a door"
            else
                left_room = "a wall"
            end
        elsif $p_direction == [-1,0]
            if left_room[-1] == "r"
                
                left_room[-1] = "a door"
            else
                left_room[-1] = "a wall"
            end
        end
    elsif left_room == "empty"
        left_room = "a wall"
    elsif left_room == "path"
        left_room = "a path" #Randomise exakt, typ "pathway" eller "tunnel"
    elsif left_room == "entrance"
        left_room = "the entrance"
    end

    back_room = $map_walls[$p_pos[0] + rotate_vector($p_direction, 180)[0]][$p_pos[1] + rotate_vector($p_direction, 180)[1]]
    if back_room.include?("room")
        if $p_direction == [0,1]
            if back_room[-1] == "l"
                back_room = "a door"
            else 
                back_room = "a wall"
            end
        elsif $p_direction == [0,-1]
            if back_room[-1] == "r"
                back_room = "a door"
            else 
                back_room = "a wall"
            end
        elsif $p_direction == [1,0]
            if back_room[-1] == "u"
                back_room = "a door"
            else
                back_room = "a wall"
            end
        else 
            back_room = "a wall"
        end
    elsif back_room == "empty"
        back_room = "a wall"
    elsif back_room == "path"
        back_room = "a path" #Randomise exakt, typ "pathway" eller "tunnel"
    elsif back_room == "entrance"
        back_room = "the entrance"
    end

    if $p_pos == [0,2] && $p_direction == [1,0]
        return "You have 3 corridors around you, one straight forward and one on either side of you. Which way do you go?"

    elsif $p_pos == [1,2] && $p_direction == [1,0]
        return "As you walk down the corridor you encounter two doors on either side, while the corridor keeps going. The doors \nappear to be unlocked."
    elsif $p_pos == [2,2] && $p_direction == [1,0]
        return "Further down the dark tunnel you see another set of doors, same as the last ones."
    elsif $p_pos == [3,2] && $p_direction == [1,0]
        return "You keep walking even further down the tunnel when you see yet another door, this one only on \nyour left side. This time the door has a rusty lock."
    elsif $p_pos == [4,2] && $p_direction == [0,1]
        return "Now the corridor turns sharply to your right, and in the light of your \nlantern it seems to go on for a long distance ahead."
    elsif $p_pos == [0,0] && $p_direction == [0,-1]
        return "After a few minutes of walking through the tunnel, you see it turning abruptly to your left"
    else
        return "In front of you now is #{front_room}, to your right is #{right_room}, to your left #{left_room} and behind you is #{back_room}"
    end

    # pos = $p_pos + $p_direction.rotate(90)
    # $map[pos.y][pos.x]
end