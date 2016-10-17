//
//  Pokemon.swift
//  Pokedex3
//
//  Created by Upendar Gareri on 10/10/2016.
//  Copyright © 2016 Upendar Gareri. All rights reserved.
//

import Foundation

class Pokemon {
    
    fileprivate var _name: String!
    fileprivate var _pokeId: Int!
    
    var name: String {
        return _name
    }
    var pokeId: Int {
        return _pokeId
    }
    
    init(name: String, pokeId: Int) {
        _name = name
        _pokeId = pokeId
    }
}
