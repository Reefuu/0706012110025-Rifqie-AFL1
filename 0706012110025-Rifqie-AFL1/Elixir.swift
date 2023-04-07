//
//  Elixir.swift
//  0706012110025-Rifqie-AFL1
//
//  Created by Rifqie Tilqa Reamizard on 24/03/23.
//

import Foundation

class Elixir: Item{
    var manapoints: Int
    
    init(name: String, description: String, manapoints: Int) {
        self.manapoints = manapoints
        
        super.init(name: name, description: description)
    }
}
