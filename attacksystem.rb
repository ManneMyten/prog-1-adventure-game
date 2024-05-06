
$damage = 0
$hp = 5
$skeleton_hp =  4
$spider_hp = 8


def attack(enemy_hp, weapon)
  if weapon  == "dagger"
    $damage = rand(1..3) # 0% chans att döda skelett (1 slag)
  elsif weapon == "sword"
    $damage = rand(2..6) # 60% chans att döda skelett (1 slag)
  elsif weapon == ("spear" || "enchanted spear" || "enchantedspear")
    $damage = rand(3..8) # 83,333% chans att döda skelett (1 slag)
  end
  return enemy_hp - $damage #skickar tillbaka hur mycket hp fienden har kvar
end

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

    #Spelaren attackerar
    if action[0] == "attack"
      weapon = action[2]
      enemy_hp = attack(enemy_hp, weapon) #ger resulterande hp efter attack
      puts "You delt #{$damage} damage to the #{enemy}"
    elsif action[0] == "leave" || action[0] == "exit" || action[0] == "walk"
      puts "You can't exit the room whilst in combat."
    elsif action[0] == "open"
      puts "You can't open things whilst you're in combat."
    elsif action[0] + action[1] == "drink" + "potion" && $hp < 5
      healed =  5 - $hp
      $hp += healed
      puts "You drink the potion, it healed #{healed} points of health"

      #*************** REMOVE 1 POTION FROM INVENTORY ***************#

    elsif action[0] + action[1] == "drink" + "potion" && $hp == 5
      puts "You are already on full health, you can't drink the potion"
    end

    #fienden attackerar
    if enemy_hp >= 1
      if enemy == "spider"
        $damage = (rand(1..3))
        $hp -= $damage
        puts "The #{enemy} dealt #{$damage} to you."
      end
      if enemy == "skeleton"
        $damage = (rand(0..2))
        $hp -= $damage
        puts "The #{enemy} dealt #{$damage} to you."
      end
    end

  end

  if enemy_hp < 1
    puts "You dealt #{$damage} damage and killed the #{enemy}." #ändra till fancy text. (om vi vill)
    rooms(room).delete_at(2)
  end

  if $hp < 1
    puts "As the #{enemy} hits you, you fall to the ground. \n The darkness slowly creeps in as you ly dying on the cold coarse dungeon floor."
    puts "You have died, another soul is swallowed by the dark dungeon."
    #end game
  end
end
