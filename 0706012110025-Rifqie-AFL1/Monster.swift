//
//  Monster.swift
//  0706012110025-Rifqie-AFL1
//
//  Created by Rifqie Tilqa Reamizard on 24/03/23.
//

import Foundation

protocol Enemy{
    var hp: Int {get set}
    var name: String {get set}
    var damage: Int {get set}
}

struct Monster: Enemy{
    var hp: Int
    var name: String
    var damage: Int
    
    init(hp: Int, name: String, damage: Int) {
        self.hp = hp
        self.name = name
        self.damage = damage
    }
}



