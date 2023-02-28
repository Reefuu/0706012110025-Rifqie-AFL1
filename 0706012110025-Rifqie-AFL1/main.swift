//
//  main.swift
//  0706012110025-Rifqie-AFL1
//
//  Created by Rifqie Tilqa Reamizard on 28/02/23.
//

import Foundation
let symbolsSet = CharacterSet(charactersIn: "=< >`~!@#$%^&*()-_+={}[]|;:'\",.<>?/")
var choice_open: String = ""
var choice_journey: String = ""
var choice_return: String = ""
var choice_heal: String = ""
var choice_action: String = ""
var name: String = ""
var hp = 100, mp = 50
let max_hp = 100, max_mp = 50
var potions: Int = 10
var elixir: Int = 5
var magic_atk = ["Physical Attack", "Meteor", "Shield"]
var magic_mp = [0, 15, 10]
var magic_usage = ["No mana required", "Use \(magic_mp[1])pt of MP", "Use \(magic_mp[2])pt of MP"]
var magic_power = [5, 50, 1]
var magic_desc = ["Deal \(magic_power[0])pt of damage", "Deal \(magic_power[1])pt of damage", "Block enemy's attack for \(magic_power[2]) turn(s)"]
var items = [potions, elixir]
var item_name = ["Potions", "Elixir"]
var item_gain = [20, 10]
var item_desc = ["Heal \(item_gain[0])pt of your HP", "Add \(item_gain[1])pt of your MP"]
var enemy_name = ["Troll", "Golem"]
var enemy_health = [1000, 1000]
var other_action = ["Use \(item_name[0].dropLast()) to heal wound", "Scan enemy's vital", "Flee from battle"]


openScreen()

func openScreen(){
    print("""
          
          Welcome to the world of magic! 🧙‍♂️🧌
          
          You have been chosen to embark on an epic journey as a young wizard on the path to becoming the master of the
          \tarcane arts. Your adventures will take you through forests 🌲, mountains ⛰️, and dungeons 🏰, where you will
          \tface challenges, make allies, and fight enemies.
          
          Press [return] to continue:
          """, terminator: " ")
    
    choice_open = readLine()!
    
    switch choice_open{
    case "":
        welcomeScreen()
    default:
        openScreen()
    }
}

func welcomeScreen(){
    print("\nMay i know your name, young wizard?", terminator: " ")
    name = readLine()!
    
    if name.contains(where: { $0.isNumber}) || name.isEmpty || name.rangeOfCharacter(from: symbolsSet) != nil{
        welcomeScreen()
    }else{
        journeyScreen()
    }
    
    }

func journeyScreen(){
        print("""
              \nNice to meet you \(name)!
              
              From here, you can...
              
              [C]heck your health and stats
              [H]eal your wounds with potion
              
              ...or choose where you want to go
              
              [F]orest of Troll
              [M]ountain of Golem
              [Q]uit game
              
              Your choice?
              """, terminator: " ")
        
    choice_journey = readLine()!.lowercased()
    
    switch choice_journey{
    case "c":
        playerScreen()
    case "h":
        healWound(screen: "journey")
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
    
    choice_return = readLine()!
    
    switch choice_return{
    case "":
        journeyScreen()
    default:
        playerScreen()
    }
}

func healWound(screen: String){
    if potions == 0 {
        noHeal(screen: screen)
    }
    print("""
          
          Your HP is \(hp).
          You have \(potions) \(item_name[0]).
          
          Are you sure you want to use 1 potion to heal wound? [Y/N]
          """, terminator: " ")
            
    choice_heal = readLine()!.lowercased()
    
    switch choice_heal{
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
func healAgain(screen: String){
    if potions == 0 {
        noHeal(screen: screen)
    }
    print("""
          
          Your HP is now \(hp).
          You have \(potions) \(item_name[0].dropLast()) left.
          
          Still want to use 1 potion to heal wound again? [Y/N]
          """, terminator: " ")
            
    choice_heal = readLine()!.lowercased()
    
    switch choice_heal{
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
func noHeal(screen: String){
    print("""
          
          You don't have any potion left. Be careful of your next journey.
          
          Press [return] to go back:
          """, terminator: " ")
    
    choice_return = readLine()!
    
    switch choice_return{
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

func forestScreen(){
    if enemy_health[enemy_name.firstIndex(of: "Troll")!] <= 0{
            killForest()
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
    choice_action = readLine()!
    
    switch choice_action{
    case "1":
        enemy_health[enemy_name.firstIndex(of: "Troll")!] -= 5
        forestScreen()
    case "2":
        enemy_health[enemy_name.firstIndex(of: "Troll")!] -= 50
        forestScreen()
    case "3":
        forestScreen()
    case "4":
        healWound(screen: "forest")
    case "5":
        forestScreen()
    case "6":
        fleeScreen()
    default:
        forestScreen()
    }
    
}

func enemyStats(enemy: String, count: Int){
    let intIndex = enemy_name.firstIndex(of: enemy)
    print("""
          😈 Name: \(enemy_name[intIndex!]) x\(count)
          😈 Health: \(enemy_health[intIndex!])
          """)
}

func killForest(){
    print("\nYou killed the troll")
    enemy_health[enemy_name.firstIndex(of: "Troll")!] = 1000
    journeyScreen()
}

func killGolem(){
    print("\nYou killed the golem")
    enemy_health[enemy_name.firstIndex(of: "Golem")!] = 1000
    journeyScreen()
}


func golemScreen(){
    if enemy_health[enemy_name.firstIndex(of: "Golem")!] <= 0{
            killGolem()
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
    choice_action = readLine()!
    
    switch choice_action{
    case "1":
        enemy_health[enemy_name.firstIndex(of: "Golem")!] -= 5
        golemScreen()
    case "2":
        enemy_health[enemy_name.firstIndex(of: "Golem")!] -= 50
        golemScreen()
    case "3":
        golemScreen()
    case "4":
        healWound(screen: "golem")
    case "5":
        golemScreen()
    case "6":
        fleeScreen()
    default:
        golemScreen()
    }
    
}

func fleeScreen(){
    print("""
          
          You feel that as if you don't escape soon, you won't be able to continue the fight.
          You look around frantically, searching for a way out. You sprint towards the exit, your heart pounding in your
          \tchest.
          
          You're safe, for now.
          Press [return] to continue:
          """, terminator: " ")
    
    choice_return = readLine()!
    
    switch choice_return{
    case "":
        journeyScreen()
    default:
        fleeScreen()
    }
}
