#Map koordinater map[row][col]
$map = [
    ["path", "path", "entrance", "path", "path", nil],
    ["path", "room1", "path", "room2", "path", nil],
    ["path", "room3", "path", "room4", "path", nil],
    ["room5", "empty", "path", "room6", "path", nil],
    ["room7", "path", "path", "empty", "room8", nil]
]

$player_coordinates = [0, 2]
$player_direction = [1, 0]

def rotate_vector(vec, angle)
    rad = angle * Math::PI / 180
    x = vec[0] * Math.cos(rad) - vec[1] * Math.sin(rad)
    y = vec[0] * Math.sin(rad) + vec[1] * Math.cos(rad)

    return [x.to_i, y.to_i]
end

def collision(direction)
    if direction == "right"
        $player_direction = rotate_vector($player_direction, -90)
    elsif direction == "left"
        $player_direction = rotate_vector($player_direction, 90)
    elsif direction == "back"
        $player_direction = rotate_vector($player_direction, 180)
    end

    if $map[$player_coordinates[0] + $player_direction[0]][$player_coordinates[1] + $player_direction[1]] != "path" && $map[$player_coordinates[0] + $player_direction[0]][$player_coordinates[1] + $player_direction[1]] != "entrance"
        if direction == "right"
            $player_direction = rotate_vector($player_direction, 90)
        elsif direction == "left"
            $player_direction = rotate_vector($player_direction, -90)
        elsif direction == "back"
            $player_direction = rotate_vector($player_direction, 180)
        end
        return false
    else
        return true
    end
end

def move(direction)

    if collision(direction)
        $player_coordinates[0] += $player_direction[0]
        $player_coordinates[1] += $player_direction[1]
        p $player_direction
        p $player_coordinates
        return true
    else
        return false
    end

end

def enter_room(direction)
    if direction == "right"
        $player_direction = rotate_vector($player_direction, -90)
    elsif direction == "left"
        $player_direction = rotate_vector($player_direction, 90)
    elsif direction == "back"
        $player_direction = rotate_vector($player_direction, 180)
    end

    if !$map[$player_coordinates[0] + $player_direction[0]][$player_coordinates[1] + $player_direction[1]].include?("room")
        if direction == "right"
            $player_direction = rotate_vector($player_direction, 90)
        elsif direction == "left"
            $player_direction = rotate_vector($player_direction, -90)
        elsif direction == "back"
            $player_direction = rotate_vector($player_direction, 180)
        end
        return false
    else
        $player_coordinates[0] += $player_direction[0]
        $player_coordinates[1] += $player_direction[1]
        p $player_direction
        p $player_coordinates
        return true
    end
end


