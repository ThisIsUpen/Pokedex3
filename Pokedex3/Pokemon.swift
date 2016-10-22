//
//  Pokemon.swift
//  Pokedex3
//
//  Created by Upendar Gareri on 10/10/2016.
//  Copyright © 2016 Upendar Gareri. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    
    private var _name: String!
    private var _pokeId: Int!
    private var _description: String!
    private var _type: String!
    private var _defence: String!
    private var _height: String!
    private var _weight: String!
    private var _baseAttack: String!
    private var _nextEvolutionText: String!
    private var _pokemonURL: String!
    
    var name: String {
        return _name
    }
    var pokeId: Int {
        return _pokeId
    }
    
    var description: String {
        if _description == nil {
            _description = ""
        }
        return _description
    }
    
    var type: String {
        if _type == nil {
            _type = ""
        }
        return _type
    }
    
    var defence: String {
        if _defence == nil {
            _defence = ""
        }
        return _defence
    }
    
    var height: String {
        if _height == nil {
            _height = ""
        }
        return _height
    }
    
    var weight: String {
        if _weight == nil {
            _weight = ""
        }
        return _weight
    }
    
    var baseAttack: String {
        if _baseAttack == nil {
            _baseAttack = ""
        }
        return _baseAttack
    }
    
    var nextEvolutionText: String {
        if _nextEvolutionText == nil {
            _nextEvolutionText = ""
        }
        return _nextEvolutionText
    }
    
    
    init(name: String, pokeId: Int) {
        self._name = name
        self._pokeId = pokeId
        self._pokemonURL = "\(BASE_URL)\(POKEMON_URL)\(self.pokeId)" //when get - use var variable and when set - use private var
    }
    
    func downloadPokemonDetail(completed: @escaping DownloadComplete) {
        
        Alamofire.request(_pokemonURL).responseJSON { (response) in
            if let dict = response.result.value as? Dictionary<String, Any> {
                
                if let attack = dict["attack"] as? Int {
                    self._baseAttack = "\(attack)" //when get - use var variable and when set - use private var
                }
                if let defense = dict["defense"] as? Int {
                    self._defence = "\(defense)"
                }
                if let height = dict["height"] as? String {
                    self._height = height
                }
                if let weight = dict["weight"] as? String {
                    self._weight = weight
                }
                
            }
            completed()
        }
        
    }
    
}
