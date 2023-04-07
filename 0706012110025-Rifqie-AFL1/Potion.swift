//
//  Potion.swift
//  0706012110025-Rifqie-AFL1
//
//  Created by Rifqie Tilqa Reamizard on 24/03/23.
//

import Foundation

class Potion: Item{
    var healthpoints: Int
    
    init(name: String, description: String, healthpoints: Int) {
        self.healthpoints = healthpoints
        
        super.init(name: name, description: description)
    }
    
}
