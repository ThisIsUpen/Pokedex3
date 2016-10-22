//
//  PokemonDetailVC.swift
//  Pokedex3
//
//  Created by Upendar Gareri on 17/10/2016.
//  Copyright © 2016 Upendar Gareri. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {

    var pokemon: Pokemon!
    
    @IBOutlet weak var mainLbl: UILabel!
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var pokeIdLbl: UILabel!
    @IBOutlet weak var baseAttackLbl: UILabel!
    @IBOutlet weak var nextEvoLbl: UILabel!
    @IBOutlet weak var currentEvoImg: UIImageView!
    @IBOutlet weak var nextEvoImg: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainLbl.text = self.pokemon.name.capitalized
        let image = UIImage(named: "\(self.pokemon.pokeId)")
        
        self.mainImg.image = image
        self.currentEvoImg.image = image
        self.pokeIdLbl.text = "\(self.pokemon.pokeId)"
        
        pokemon.downloadPokemonDetail {
            // this is my closure
            // this part will be called after the api object download is complete
            // I can update the UI of this controller here
            // use self inside closure
            
            self.updateUI()
        }

    }
    
    func updateUI() {
        self.heightLbl.text = self.pokemon.height
        self.weightLbl.text = self.pokemon.weight
        self.defenseLbl.text = self.pokemon.defence
        self.baseAttackLbl.text = self.pokemon.baseAttack
        
        self.descriptionLbl.text = self.pokemon.description
        self.typeLbl.text = self.pokemon.type
        
        if self.pokemon.nextEvoId == "" {
            self.nextEvoLbl.text = "No Further Evolution"
            self.nextEvoImg.isHidden = true
        } else {
            self.nextEvoImg.isHidden = false
            self.nextEvoImg.image = UIImage(named: self.pokemon.nextEvoId)
            
            self.nextEvoLbl.text = "Next Evolution: \(self.pokemon.nextEvoName) - Level \(self.pokemon.nextEvoLevel)"
        }
    }

    @IBAction func backBtnPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
