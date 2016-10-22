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
    private var _nextEvoName: String!
    private var _nextEvoLevel: String!
    private var _nextEvoId: String!
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
    
    var nextEvoName: String {
        if _nextEvoName == nil {
            _nextEvoName = ""
        }
        return _nextEvoName
    }
    
    var nextEvoLevel: String {
        if _nextEvoLevel == nil {
            _nextEvoLevel = ""
        }
        return _nextEvoLevel
    }
    
    var nextEvoId: String {
        if _nextEvoId == nil {
            _nextEvoId = ""
        }
        return _nextEvoId
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
                
                if let descriptions = dict["descriptions"] as? [Dictionary<String, String>], descriptions.count > 0 {
                    if let uri = descriptions[0]["resource_uri"] {
                        let description_URL = "\(BASE_URL)\(uri)"
                        
                        Alamofire.request(description_URL).responseJSON(completionHandler: { (descriptionResponse) in
                            if let descDict = descriptionResponse.result.value as? Dictionary<String, Any> {
                                if let description = descDict["description"] as? String {
                                    let newDescription = description.replacingOccurrences(of: "POKMON", with: "Pokemon")
                                    self._description = newDescription
                                }
                            }
                            completed()
                        })
                    }
                    
                }
                
                if let types = dict["types"] as? [Dictionary<String, String>], types.count > 0 {
                    
                    if let name = types[0]["name"] {
                        self._type = name.capitalized
                    }
                    
                    if types.count > 1 {
                        for x in 1..<types.count {
                            if let name = types[x]["name"] {
                                self._type! += "/\(name.capitalized)" //here if self.type is nil for the first time then it'll not append and give error. Hence for the first time it has been given a value from the 0th index and henceforth iterated to append the value.
                            }
                            
                        }
                    }
                    
                } else {
                    self._type = "Unknown"
                }
                
                if let evolutions = dict["evolutions"] as? [Dictionary<String, Any>], evolutions.count > 0 {
                    if let nextEvo = evolutions[0]["to"] as? String {
                        if nextEvo.range(of: "mega") == nil {
                            self._nextEvoName = nextEvo
                            
                            if let nextLvl = evolutions[0]["level"] as? Int {
                                self._nextEvoLevel = "\(nextLvl)"
                                
                            } else {
                                self._nextEvoLevel = ""
                            }
                            
                            if let resource_uri = evolutions[0]["resource_uri"] as? String {
                                let newStr = resource_uri.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                                let nextEvo = newStr.replacingOccurrences(of: "/", with: "")
                                
                                self._nextEvoId = nextEvo
                            }
                        }
                    }
                } else {
                    self._nextEvoId = ""
                    self._nextEvoName = ""
                    self._nextEvoLevel = ""
                }
                
                
            }
            completed()
        }
        
    }
    
}
