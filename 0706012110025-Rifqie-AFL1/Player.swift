//
//  Player.swift
//  0706012110025-Rifqie-AFL1
//
//  Created by Rifqie Tilqa Reamizard on 24/03/23.
//

import Foundation

class Player{
    var hp: Int = 130
    var name: String
    var mp: Int = 80
    var scanned: Bool = false
    var block: Bool = false
    var inventory: Array<Item> = []
    var actions: Array<Action> = []
    let potion = Potion(name: "Potion", description: "Restores Health", healthpoints: 30)
    let elixir = Elixir(name: "Elixir", description: "Restores Mana", manapoints: 20)
    let physical_attack = Action(name: "Physical Attack", mp_usage: 0, damage: 15, description: "Attack the enemy with your fist. Uses 0 mana")
    let meteor = Action(name: "Meteor", mp_usage: 15, damage: 50, description: "Summons a meteor that befalls upon your enemy. Uses 15 mana")
    let shield = Action(name: "Block", mp_usage: 10, damage: 0, description: "Wield the shield to block yourself from the enemy's attack. Uses 10 mana")
    let recoverHP = Action(name: "Heal", mp_usage: 0, damage: -1, description: "Uses one of your potion to heal your lost HP by 30")
    let recoverMP = Action(name: "Recover", mp_usage: 0, damage: -1, description: "Uses one of your elixir to recover your lost MP by 20")
    let scan = Action(name: "Scan enemy's vital", mp_usage: 0, damage: -1, description: "Scans the enemy's vital spot to deal 2x Damage")
    let flee = Action(name: "Flee from battle", mp_usage: 0, damage: -1, description: "Escape the inevitable doom you are fighting")
    
        
    init(name: String) {
        self.name = name
        for _ in 1...20{
            self.inventory.append(potion)
        }
        for _ in 1...15{
            self.inventory.append(elixir)
        }
        actions += [physical_attack, meteor, shield, recoverHP, recoverMP, scan, flee]
    }
    
    func gainItem(item: Item){
        if item is Potion{
            self.inventory.append(potion)
        }else if item is Elixir{
            self.inventory.append(elixir)
        }
    }
    
    func itemCount(choice: String = ""){
        let potionCount: Int = inventory.filter{$0 is Potion}.count
        let elixirCount: Int = inventory.filter{$0 is Elixir}.count
        if choice == ""{
            print("""
                  
                  - Potion. x\(potionCount). \(potion.description)
                  - Elixir. x\(elixirCount). \(elixir.description)
                  """)
        }else if choice == "p"{
            print("""
                  
                  - Potion. x\(potionCount). \(potion.description)
                  """)
        }else if choice == "e"{
            print("""
                  
                  - Elixir. x\(elixirCount). \(elixir.description)
                  """)
        }
    }
    
    
    func useItem(item: Item){
        if item is Potion{
                        
            let usePotion = item as! Potion
            
            inventory.remove(at: inventory.firstIndex(where: {$0 is Potion})!)
            
            hp += usePotion.healthpoints
            
            if hp >= 130{hp = 130}
        }else if item is Elixir{
            
            let useElixir = item as! Elixir
            
            inventory.remove(at: inventory.firstIndex(where: {$0 is Elixir})!)
            
            mp += useElixir.manapoints
            
            if mp >= 80{mp = 80}
            
            }
    }
    
    func actionList() -> Int{
        for action in actions {
            print("\n- [\(action.name.prefix(1))]\(action.name.dropFirst()). \(action.description)")
        }
        print("\nYour choice?", terminator: " ")
        let choice = readLine()!.uppercased()
        let act = doAction(choice: choice)
        return act
    }
    
    func doAction(choice: String) -> Int{
        for action in actions {
            if choice == action.name.prefix(1){
                mp -= action.mp_usage
                if mp < 0 {
                    mp += action.mp_usage
                    return 0
                }
                if action.name == "Physical Attack"{
                    return action.damage
                }
                if action.name == "Meteor"{
                    return action.damage
                }
                if action.name == "Block"{
                    block = true
                    return -1
                }
                if action.name.prefix(1) == "S"{
                    scanned = true
                    return -2
                }
                if action.name == "Heal"{
                    return -3
                }
                if action.name == "Recover"{
                    return -4
                }
                if action.name == "Flee from battle"{
                    return -5
                }
            }
        }
        return 0
    }
}
