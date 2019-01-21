//
//  ListBeersCell.swift
//  iBeer
//
//  Created by Jefferson Martins de Sá on 20/01/2019.
//  Copyright © 2019 Jefferson Martins de Sá. All rights reserved.
//

import UIKit
import AlamofireImage

class ListBeersCell: UITableViewCell {

    @IBOutlet weak var beerImageVIew: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var abvLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setCell(beer:ListBeers.FetchBeers.ViewModel.DisplayedBeer) {
        
        if let url = URL(string: beer.image_url) {
            self.beerImageVIew?.af_setImage(withURL: url, completion: { response in
                self.setNeedsLayout()
                self.beerImageVIew.backgroundColor = UIColor.clear
            })
            
        }
        
        self.nameLabel.text = beer.name
        self.abvLabel.text = "Alcohol by volume: \(beer.abv)"
        self.nameLabel.backgroundColor = UIColor.clear
        self.abvLabel.backgroundColor = UIColor.clear
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
