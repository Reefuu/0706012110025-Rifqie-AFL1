//
//  Action.swift
//  0706012110025-Rifqie-AFL1
//
//  Created by Rifqie Tilqa Reamizard on 24/03/23.
//

import Foundation

class Action{
    var name: String
    var mp_usage: Int
    var damage: Int
    var description: String
    
    init(name: String, mp_usage: Int, damage: Int, description: String) {
        self.name = name
        self.mp_usage = mp_usage
        self.damage = damage
        self.description = description
    }
}
