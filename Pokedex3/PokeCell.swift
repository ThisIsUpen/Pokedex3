//
//  PokeCell.swift
//  Pokedex3
//
//  Created by Upendar Gareri on 10/10/2016.
//  Copyright © 2016 Upendar Gareri. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    @IBOutlet weak var cellThumb: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.layer.cornerRadius = 5.0
        
    }
    
    func updateUI(_ pokemon: Pokemon) {
        cellThumb.image = UIImage(named: "\(pokemon.pokeId)")
        nameLbl.text = pokemon.name
    }
}
