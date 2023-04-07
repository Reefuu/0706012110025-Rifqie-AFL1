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
var player: Player?
let max_hp = 130, max_mp = 80

// Enemy
var troll = Monster(hp: 1000, name: "Troll", damage: 20)
var golem = Monster(hp: 1000, name: "Golem", damage: 20)
var enemy: Monster?
var enemy_countdown = 1

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
        player = Player(name: name)
        journeyScreen()
    }
}

// Journey Screen (you go back here everytime)
func journeyScreen(){
    enemy_countdown = 1
    player?.scanned = false
    print("""
              \nNice to meet you \(player?.name ?? "")!
              
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
        setEnemy(choice: choice)
    case "m":
        setEnemy(choice: choice)
    case "q":
        exit(0)
    default:
        journeyScreen()
    }
}

//Initialize the enemy you will be facing
func setEnemy(choice: String){
    if choice == "f"{
        enemy = troll
        forestScreen()
    }else if choice == "m"{
        enemy = golem
        golemScreen()
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
    if player?.inventory.filter({$0 is Elixir}).count == 0{
        noRecover(screen: screen)
    }
    print("""
          
          Your MP is \(player?.mp ?? 0).
          You have \(player?.inventory.filter({$0 is Elixir}).count ?? 0) elixir(s).

          Are you sure you want to use 1 elixir to recover MP? [Y/N]
          """, terminator: " ")
    
    choice = readLine()!.lowercased()
    
    switch choice{
    case "y":
        player?.useItem(item: player!.elixir)
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
    if player?.inventory.filter({$0 is Potion}).count == 0 {
        noHeal(screen: screen)
    }
    print("""
          
          Your HP is \(player?.hp ?? 0).
          You have \(player?.inventory.filter({$0 is Potion}).count ?? 0) potion(s).
          
          Are you sure you want to use 1 potion to heal wound? [Y/N]
          """, terminator: " ")
    
    choice = readLine()!.lowercased()
    
    switch choice{
    case "y":
        player?.useItem(item: player!.potion)
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
    if player?.inventory.filter({$0 is Potion}).count == 0 {
        noHeal(screen: screen)
    }
    print("""
          
          Your HP is now \(player?.hp ?? 0).
          You have \(player?.inventory.filter({$0 is Potion}).count ?? 0) potion left.

          Still want to use 1 potion to heal wound again? [Y/N]
          """, terminator: " ")
    
    choice = readLine()!.lowercased()
    
    switch choice{
    case "y":
        player?.useItem(item: player!.potion)
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
    if player?.inventory.filter({$0 is Elixir}).count == 0 {
        noRecover(screen: screen)
    }
    print("""
          
          Your MP is now \(player?.mp ?? 0).
          You have \(player?.inventory.filter({$0 is Elixir}).count ?? 0) elixir left.

          Still want to use 1 elixir to recover MP again? [Y/N]
          """, terminator: " ")
    
    choice = readLine()!.lowercased()
    
    switch choice{
    case "y":
        player?.useItem(item: player!.elixir)
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
          
          You don't have any potion left. Be careful on your next journey.
          
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
          
          You don't have any elixir left. Be careful on your next journey.
          
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
          
          Player name: \(player?.name ?? "")
          
          HP: \(player?.hp ?? 0)/\(max_hp)
          MP: \(player?.mp ?? 0)/\(max_mp)
          
          Magic:
          """)
    for item in player!.actions {
        if item.damage >= 0{
            print("- \(item.name). \(item.description)")
        }
    }
    print("""
          
          Items:
          """)
    player?.itemCount()
    
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
    if enemy!.hp <= 0{
        killEnemy()
    }
    if player!.hp <= 0{
        playerDie()
    }
    if player!.block{
        player!.block = false
    }
    print("""
          
          As you enter the forest, you feel a sense of unease wash over you.
          Suddenly, you hear the sound of twigs snapping behind you. You quickly spin around, and find a Troll emerging
          \tfrom the shadows.
          
          """)
    
    enemyStats(enemy: enemy!)
    
    print("""
          
          Choose your action:
          """)
    var result = player?.actionList()
    
    if result == 0 {
        forestScreen()
    }
    
    if result == -5 {
        journeyScreen()
    }
    
    if result == -2 {
        print("\nYou have scanned the enemy's vital spot, you now deal 2x damage")
    }
    
    if result == -3 {
        if player?.inventory.filter({$0 is Potion}).count == 0{
            print("\nYou wasted your turn searching for a potion")
        }else{
            print("\nYou healed some of your lost health")
            player?.useItem(item: player!.potion)
        }
    }
    
    if result == -4 {
        if player?.inventory.filter({$0 is Elixir}).count == 0{
            print("\nYou wasted your turn searching for an elixir")
        }else{
            print("\nYou recovered some of your lost mana")
            player?.useItem(item: player!.elixir)
        }
    }
    
    if enemy_countdown == 0{
        if player!.block{
            print("\nYou have blocked the enemy's attack.")
        }else{
            player!.hp -= enemy!.damage
            if result! > 0 {
                if player!.scanned{
                    result? *= 2
                }
                print("\nYou dealt \(result!) damage to the enemy.")
                enemy!.hp -= result!
            }
        }
        if enemy_countdown == 1{
            enemy_countdown -= 1
        }else{
            enemy_countdown = 1
        }
        forestScreen()
    }
    if enemy_countdown == 1{
        enemy_countdown -= 1
    }else{
        enemy_countdown = 1
    }

    if result! > 0 {
        if player!.scanned{
            result? *= 2
        }
        print("\nYou dealt \(result!) damage to the enemy.")
        enemy!.hp -= result!
    }
    
    forestScreen()
}

// Killed the enemy
func killEnemy(){
    let gain_potion = Int.random(in: 1..<4)
    let gain_elixir = Int.random(in: 1..<4)
    for _ in 1...gain_potion{
        player?.gainItem(item: player!.potion)
    }
    for _ in 1...gain_elixir{
        player?.gainItem(item: player!.elixir)
    }
    print("\nYou killed the \(enemy!.name), and gained some hp back\nYou also gained \(gain_potion) Potions, and \(gain_elixir) Elixirs")
    if player!.hp>max_hp{
        player!.hp = max_hp
    }
    journeyScreen()
}

// Mountain Golem Screen
func golemScreen(){
    if enemy!.hp <= 0{
        killEnemy()
    }
    if player!.hp <= 0{
        playerDie()
    }
    if player!.block{
        player!.block = false
    }
    print("""
          
          As you climb up the mountain, you feel a presence watching over you.
          Suddenly, you hear the sound of loud roar from the stones. You quickly
          \tturned around, finding a golem forming from the stones.
          
          """)
    
    enemyStats(enemy: enemy!)
    
    print("""
          
          Choose your action:
          """)
    var result = player?.actionList()
    
    if result == 0 {
        forestScreen()
    }
    
    if result == -5 {
        journeyScreen()
    }
    
    if result == -2 {
        print("\nYou have scanned the enemy's vital spot, you now deal 2x damage")
    }
    
    if result == -3 {
        if player?.inventory.filter({$0 is Potion}).count == 0{
            print("\nYou wasted your turn searching for a potion")
        }else{
            print("\nYou healed some of your lost health")
            player?.useItem(item: player!.potion)
        }
    }
    
    if result == -4 {
        if player?.inventory.filter({$0 is Elixir}).count == 0{
            print("\nYou wasted your turn searching for an elixir")
        }else{
            print("\nYou recovered some of your lost mana")
            player?.useItem(item: player!.elixir)
        }
    }
    
    if enemy_countdown == 0{
        if player!.block{
            print("\nYou have blocked the enemy's attack.")
        }else{
            player!.hp -= enemy!.damage
            if result! > 0 {
                if player!.scanned{
                    result? *= 2
                }
                print("\nYou dealt \(result!) damage to the enemy.")
                enemy!.hp -= result!
            }
        }
        if enemy_countdown == 1{
            enemy_countdown -= 1
        }else{
            enemy_countdown = 1
        }
        golemScreen()
    }
    if enemy_countdown == 1{
        enemy_countdown -= 1
    }else{
        enemy_countdown = 1
    }

    if result! > 0 {
        if player!.scanned{
            result? *= 2
        }
        print("\nYou dealt \(result!) damage to the enemy.")
        enemy!.hp -= result!
    }
    
    golemScreen()
    
    
}

// Enemy Info
func enemyStats(enemy: Monster){
    print("""
          😈 Name: \(enemy.name)
          😈 Health: \(enemy.hp)
          """)
    if(enemy_countdown == 1){
        print("😈 Attack: The enemy will attack for \(enemy.damage) in the next turn")
    }else{
        print("😈 Attack: The enemy will attack for \(enemy.damage) in this turn")
    }
    print("""
          Your HP: \(player!.hp)/\(max_hp)
          Your MP: \(player!.mp)/\(max_mp)
          """)
    player?.itemCount()
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
