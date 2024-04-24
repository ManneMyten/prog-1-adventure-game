
$damage = 0
$hp = 5
$skeleton_hp =  4
$spider_hp = 8


def combat(room)
  enemy = rooms(room)[2]

  enemy_hp = 0
  if enemy == "skeleton"
    enemy_hp = $skeleton_hp
  elsif enemy == "spider"
    enemy_hp = $spider_hp
  end

  while $hp > 0 && enemy_hp > 0
    action = gets.chomp.downcase.split
    if action[0] == "attack"
      weapon = action[2]
      enemy_hp = attack(enemy_hp, weapon) #ger resulterande hp efter attack
    end
  end

  if $skeleton_hp < 1
    puts "you delt #{$damage} damage and killed the skeleton" #ändra till fancy text. (om vi vill)
  end
end

def attack(enemy_hp, weapon)
  if weapon  == "dagger"
    $damage = rand(0..3)
  elsif weapon == "sword"
    $damage = rand(2..6)
  end

  return enemy_hp - $damage #skickar tillbaka hur mycket hp fienden har kvar
end
