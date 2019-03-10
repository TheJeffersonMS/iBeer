//
//  ListBeersCell.swift
//  iBeer
//
//  Created by Jefferson Martins de Sá on 20/01/2019.
//  Copyright © 2019 Jefferson Martins de Sá. All rights reserved.
//

import UIKit
import Alamofire

class ListBeersCell: UITableViewCell {
    
    @IBOutlet weak var beerImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var abvLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setCell(beer:ListBeers.FetchBeers.ViewModel.DisplayedBeer) {
        
        if let url = URL(string: beer.image_url) {
            Alamofire.request(url, method: .get).validate().responseData { (responseData) in
                if let data = responseData.data {
                    self.beerImageView.image = UIImage(data: data)
                    DispatchQueue.main.async {
                        self.setNeedsLayout()
                        self.beerImageView.backgroundColor = UIColor.clear
                    }
                }
            }
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
