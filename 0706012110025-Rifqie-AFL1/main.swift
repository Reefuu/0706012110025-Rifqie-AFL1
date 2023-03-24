//
//  main.swift
//  0706012110025-Rifqie-AFL1
//
//  Created by Rifqie Tilqa Reamizard on 28/02/23.
//

import Foundation

// To check all possible symbols
let symbolsList = CharacterSet(charactersIn: "=< >`~!@#$%^&*()-_+={}[]|;:'\",.<>?/")

// Read line
var choice: String = ""

// User
var name: String = ""
var hp = 100, mp = 50
let max_hp = 100, max_mp = 50

// items
var potions: Int = 20
var elixir: Int = 10
var items = [potions, elixir]
var item_name = ["Potions", "Elixir"]
var item_gain = [20, 10]
var item_desc = ["Heal \(item_gain[0])pt of your HP", "Add \(item_gain[1])pt of your MP"]

// Attacks
var magic_atk = ["Physical Attack", "Meteor", "Shield"]
var magic_mp = [0, 15, 10]
var magic_usage = ["No mana required", "Use \(magic_mp[1])pt of MP", "Use \(magic_mp[2])pt of MP"]
var magic_power = [5, 50, 1]
var magic_desc = ["Deal \(magic_power[0])pt of damage", "Deal \(magic_power[1])pt of damage", "Block enemy's attack for \(magic_power[2]) turn(s)"]

// Actions (not attack)
var other_action = ["Use \(item_name[0].dropLast()) to heal wound or \(item_name[1]) to recover MP ", "Scan enemy's vital", "Flee from battle"]

// Enemy
var enemy_name = ["Troll", "Golem"]
var enemy_health = [1000, 1000]
var enemy_countdown = 1

// Damage Multiplier
var multiplier = 1

// Code Start
openScreen()



// Starting Screen
func openScreen(){
    print("""
          
          Welcome to the world of magic! 🧙‍♂️🧌
          
          You have been chosen to embark on an epic journey as a young wizard on the path to becoming the master of the
          \tarcane arts. Your adventures will take you through forests 🌲, mountains ⛰️, and dungeons 🏰, where you will
          \tface challenges, make allies, and fight enemies.
          
          Press [return] to continue:
          """, terminator: " ")
    
    choice = readLine()!
    
    switch choice{
    case "":
        welcomeScreen()
    default:
        openScreen()
    }
}

// Welcome Screen
func welcomeScreen(){
    print("\nMay i know your name, young wizard?", terminator: " ")
    name = readLine()!
    
    if name.contains(where: { $0.isNumber}) || name.isEmpty || name.rangeOfCharacter(from: symbolsList) != nil{
        welcomeScreen()
    }else{
        journeyScreen()
    }
}

// Journey Screen (you go back here everytime)
func journeyScreen(){
    enemy_countdown = 1
    multiplier = 1
    print("""
              \nNice to meet you \(name)!
              
              From here, you can...
              
              [C]heck your health and stats
              [H]eal your wounds with potion or recover MP with elixir
              
              ...or choose where you want to go
              
              [F]orest of Troll
              [M]ountain of Golem
              [Q]uit game
              
              Your choice?
              """, terminator: " ")
    
    choice = readLine()!.lowercased()
    
    switch choice{
    case "c":
        playerScreen()
    case "h":
        healOrRecover(screen: "journey")
    case "f":
        forestScreen()
    case "m":
        golemScreen()
    case "q":
        exit(0)
    default:
        journeyScreen()
    }
}

// Healing
func healOrRecover(screen: String){
    print("""
          \nWould you like to:
          [H]eal wound with potion
          [R]ecover MP with elixir
          
          Your choice?
          """, terminator: " ")
    choice = readLine()!.lowercased()
    
    switch choice{
    case "h":
        healWound(screen: screen)
    case "r":
        recoverMP(screen: screen)
    default:
        healOrRecover(screen: screen)
    }
}

// Recover MP
func recoverMP(screen: String){
    if elixir == 0{
        noRecover(screen: screen)
    }
    print("""
          
          Your MP is \(mp).
          You have \(elixir) \(item_name[1]).
          
          Are you sure you want to use 1 elixir to recover MP? [Y/N]
          """, terminator: " ")
    
    choice = readLine()!.lowercased()
    
    switch choice{
    case "y":
        mp += 15
        elixir -= 1
        if mp > max_mp{mp = max_mp}
        recoverAgain(screen: screen)
    case "n":
        if screen == "journey"{
            journeyScreen()
        }else if screen == "forest"{
            forestScreen()
        }else if screen == "golem"{
            golemScreen()
        }
        
    default:
        recoverMP(screen: screen)
    }
}

// Heal Wound
func healWound(screen: String){
    if potions == 0 {
        noHeal(screen: screen)
    }
    print("""
          
          Your HP is \(hp).
          You have \(potions) \(item_name[0]).
          
          Are you sure you want to use 1 potion to heal wound? [Y/N]
          """, terminator: " ")
    
    choice = readLine()!.lowercased()
    
    switch choice{
    case "y":
        hp += 20
        potions -= 1
        if hp > max_hp{hp = max_hp}
        healAgain(screen: screen)
    case "n":
        if screen == "journey"{
            journeyScreen()
        }else if screen == "forest"{
            forestScreen()
        }else if screen == "golem"{
            golemScreen()
        }
        
    default:
        healWound(screen: screen)
    }
}

// Heal Again
func healAgain(screen: String){
    if potions == 0 {
        noHeal(screen: screen)
    }
    print("""
          
          Your HP is now \(hp).
          You have \(potions) \(item_name[0].dropLast()) left.
          
          Still want to use 1 potion to heal wound again? [Y/N]
          """, terminator: " ")
    
    choice = readLine()!.lowercased()
    
    switch choice{
    case "y":
        hp += 20
        potions -= 1
        if hp > max_hp{hp = max_hp}
        healAgain(screen: screen)
    case "n":
        if screen == "journey"{
            journeyScreen()
        }else if screen == "forest"{
            forestScreen()
        }else if screen == "golem"{
            golemScreen()
        }
    default:
        healAgain(screen: screen)
    }
}

// Recover MP Again
func recoverAgain(screen: String){
    if elixir == 0 {
        noRecover(screen: screen)
    }
    print("""
          
          Your MP is now \(mp).
          You have \(elixir) \(item_name[1]) left.
          
          Still want to use 1 elixir to recover MP again? [Y/N]
          """, terminator: " ")
    
    choice = readLine()!.lowercased()
    
    switch choice{
    case "y":
        mp += 15
        elixir -= 1
        if mp > max_mp{mp = max_mp}
        recoverAgain(screen: screen)
    case "n":
        if screen == "journey"{
            journeyScreen()
        }else if screen == "forest"{
            forestScreen()
        }else if screen == "golem"{
            golemScreen()
        }
    default:
        recoverAgain(screen: screen)
    }
}

// No Potions
func noHeal(screen: String){
    print("""
          
          You don't have any potion left. Be careful of your next journey.
          
          Press [return] to go back:
          """, terminator: " ")
    
    choice = readLine()!
    
    switch choice{
    case "":
        if screen == "journey"{
            journeyScreen()
        }else if screen == "forest"{
            forestScreen()
        }else if screen == "golem"{
            golemScreen()
        }
    default:
        noHeal(screen: screen)
    }
}

// No Elixir
func noRecover(screen: String){
    print("""
          
          You don't have any elixir left. Be careful of your next journey.
          
          Press [return] to go back:
          """, terminator: " ")
    
    choice = readLine()!
    
    switch choice{
    case "":
        if screen == "journey"{
            journeyScreen()
        }else if screen == "forest"{
            forestScreen()
        }else if screen == "golem"{
            golemScreen()
        }
    default:
        noRecover(screen: screen)
    }
}

// Player Info
func playerScreen(){
    print("""
          
          Player name: \(name)
          
          HP: \(hp)/\(max_hp)
          MP: \(mp)/\(max_mp)
          
          Magic:
          """)
    for (index, item) in magic_atk.enumerated() {
        print("- \(item). \(magic_usage[index]). \(magic_desc[index])")
    }
    print("""
          
          Items:
          """)
    for (index, item) in items.enumerated() {
        print("- \(item_name[index]) x\(item). \(item_desc[index])")
    }
    print("\nPress [return] to go back:", terminator: " ")
    
    choice = readLine()!
    
    switch choice{
    case "":
        journeyScreen()
    default:
        playerScreen()
    }
}

// Forest Troll Screen
func forestScreen(){
    if enemy_health[enemy_name.firstIndex(of: "Troll")!] <= 0{
        killForest()
    }
    if hp <= 0{
        playerDie()
    }
    print("""
          
          As you enter the forest, you feel a sense of unease wash over you.
          Suddenly, you hear the sound of twigs snapping behind you. You quickly spin around, and find a Troll emerging
          \tfrom the shadows.
          
          """)
    
    enemyStats(enemy: "Troll", count: 1)
    
    print("""
          
          Choose your action:
          """)
    for (index, item) in magic_atk.enumerated() {
        print("[\(index+1)] \(item). \(magic_usage[index]). \(magic_desc[index])")
    }
    print()
    for (index, item) in other_action.enumerated() {
        print("[\(index+1+magic_atk.count)] \(item).")
    }
    
    print("\nYour choice?", terminator: " ")
    choice = readLine()!
    
    switch choice{
    case "1":
        enemy_health[enemy_name.firstIndex(of: "Troll")!] -= 5*multiplier
        if enemy_countdown == 1{
            enemy_countdown-=1
            forestScreen()
        }else{
            hp-=15
            enemy_countdown = 1
            forestScreen()
        }
    case "2":
        if mp < 15{
            print("You don't have enough MP to do this action")
            forestScreen()
        }else{
            enemy_health[enemy_name.firstIndex(of: "Troll")!] -= 50*multiplier
            mp -= 15
            if enemy_countdown == 1{
                enemy_countdown-=1
                forestScreen()
            }else{
                hp-=15
                enemy_countdown = 1
                forestScreen()
            }
        }
    case "3":
        if mp < 10{
            print("You don't have enough MP to do this action")
            forestScreen()
        }else{
            mp -= 10
            if enemy_countdown == 1{
                enemy_countdown-=1
                forestScreen()
            }else{
                enemy_countdown = 1
                forestScreen()
            }
        }
    case "4":
        if enemy_countdown == 1{
            enemy_countdown-=1
        }else{
            enemy_countdown = 1
        }
        healOrRecover(screen: "forest")
    case "5":
        if multiplier == 2{
            print("You already found out about the enemy's vital spot, you can't do it again")
        }else{
            if enemy_countdown == 1{
                enemy_countdown-=1
            }else{
                enemy_countdown = 1
            }
            multiplier = 2
            print("You found out about the enemy's weak vital spot, you now deal 2x damage")
        }
        forestScreen()
    case "6":
        fleeScreen()
    default:
        forestScreen()
    }
}

// Killed the troll
func killForest(){
    let gain_potion = Int.random(in: 1..<4)
    let gain_elixir = Int.random(in: 1..<4)
    potions += gain_potion
    elixir += gain_elixir
    items = [potions, elixir]
    print("\nYou killed the troll, and gained some hp back\nYou also gained \(gain_potion) Potions, and \(gain_elixir) Elixirs")
    if hp>max_hp{
        hp = max_hp
    }
    enemy_health[enemy_name.firstIndex(of: "Troll")!] = 1000
    journeyScreen()
}

// Mountain Golem Screen
func golemScreen(){
    if enemy_health[enemy_name.firstIndex(of: "Golem")!] <= 0{
        killGolem()
    }
    if hp <= 0{
        playerDie()
    }
    print("""
          
          As you make your way through the rugged mountain terrain, you can feel the chill of the wind biting at your skin.
          Suddenly, you hear a sound that makes you freeze in your tracks. That's when you see it - a massive, snarling
          \tGolem emerging from the shadows.
          
          """)
    
    enemyStats(enemy: "Golem", count: 1)
    
    print("""
          
          Choose your action:
          """)
    for (index, item) in magic_atk.enumerated() {
        print("[\(index+1)] \(item). \(magic_usage[index]). \(magic_desc[index])")
    }
    print()
    for (index, item) in other_action.enumerated() {
        print("[\(index+1+magic_atk.count)] \(item).")
    }
    
    print("\nYour choice?", terminator: " ")
    choice = readLine()!
    
    switch choice{
    case "1":
        enemy_health[enemy_name.firstIndex(of: "Golem")!] -= 5*multiplier
        if enemy_countdown == 1{
            enemy_countdown-=1
            golemScreen()
        }else{
            hp-=15
            enemy_countdown = 1
            golemScreen()
        }
    case "2":
        if mp < 15{
            print("You don't have enough MP to do this action")
            golemScreen()
        }else{
            enemy_health[enemy_name.firstIndex(of: "Golem")!] -= 50*multiplier
            mp -= 15
            if enemy_countdown == 1{
                enemy_countdown-=1
                golemScreen()
            }else{
                hp-=15
                enemy_countdown = 1
                golemScreen()
            }
        }
    case "3":
        if mp < 10{
            print("You don't have enough MP to do this action")
            golemScreen()
        }else{
            mp -= 10
            if enemy_countdown == 1{
                enemy_countdown-=1
                golemScreen()
            }else{
                enemy_countdown = 1
                golemScreen()
            }        }
    case "4":
        if enemy_countdown == 1{
            enemy_countdown-=1
        }else{
            enemy_countdown = 1
        }
        healOrRecover(screen: "golem")
    case "5":
        if multiplier == 2{
            print("You already found out about the enemy's vital spot, you can't do it again")
        }else{
            if enemy_countdown == 1{
                enemy_countdown-=1
            }else{
                enemy_countdown = 1
            }
            multiplier = 2
            print("You found out about the enemy's vital spot, you now deal 2x damage")
        }
        golemScreen()
    case "6":
        fleeScreen()
    default:
        golemScreen()
    }
    
}

// Killed the golem
func killGolem(){
    let gain_potion = Int.random(in: 1..<4)
    let gain_elixir = Int.random(in: 1..<4)
    potions += gain_potion
    elixir += gain_elixir
    items = [potions, elixir]
    print("\nYou killed the golem, and gained some hp back\nYou also gained \(gain_potion) Potions, and \(gain_elixir) Elixirs")
    hp += 20
    if hp>max_hp{
        hp = max_hp
    }
    enemy_health[enemy_name.firstIndex(of: "Golem")!] = 1000
    journeyScreen()
}

// Enemy Info
func enemyStats(enemy: String, count: Int){
    let intIndex = enemy_name.firstIndex(of: enemy)
    print("""
          😈 Name: \(enemy_name[intIndex!]) x\(count)
          😈 Health: \(enemy_health[intIndex!])
          """)
    if(enemy_countdown == 1){
        print("😈 Attack: The enemy will attack for 15pt in the next turn")
    }else{
        print("😈 Attack: The enemy will attack for 15pt in this turn")
    }
    print("""
          Your HP: \(hp)/\(max_hp)
          Your MP: \(mp)/\(max_mp)
          """)
}

// User Flee From Battle
func fleeScreen(){
    print("""
          
          You feel that as if you don't escape soon, you won't be able to continue the fight.
          You look around frantically, searching for a way out. You sprint towards the exit, your heart pounding in your
          \tchest.
          
          You're safe, for now.
          Press [return] to continue:
          """, terminator: " ")
    
    choice = readLine()!
    
    switch choice{
    case "":
        journeyScreen()
    default:
        fleeScreen()
    }
}

// User Died
func playerDie(){
    print("""
          
          As the last bit of life drains from your body, you realize that this battle was too much for you.
          Your vision fades to black as you take your last breath, knowing that you have been defeated.
          
          Your journey ends here.
          """)
    exit(0)
}
