//
//  DetailsBeerModels.swift
//  iBeer
//
//  Created by Jefferson Martins de Sá on 20/01/2019.
//  Copyright © 2019 Jefferson Martins de Sá. All rights reserved.
//

import Foundation
import ObjectMapper

enum DetailsBeer {
    enum GetBeer {
        struct Request {
            
            var endpoint: String
            var id: Int
            
            init(id: Int) {
                self.endpoint = Endpoints.beers
                self.id = id
            }
        }
        struct Response {
            var beer: Beer
        }
        struct ViewModel {
            struct DisplayedBeer {
                var image_url: String
                var name: String
                var abv: String
                var tagline: String
                var ibu: String
                var description: String
            }
            var displayedBeer: DisplayedBeer
        }
    }
}
