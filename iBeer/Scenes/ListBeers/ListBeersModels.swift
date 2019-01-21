//
//  ListBeersModels.swift
//  iBeer
//
//  Created by Jefferson Martins de Sá on 20/01/2019.
//  Copyright © 2019 Jefferson Martins de Sá. All rights reserved.
//

import Foundation
import ObjectMapper

enum ListBeers {
    enum FetchBeers {
        
        struct Request {
            
            var endpoint: String
            var page: Int
            var per_page: Int
            
            init(page: Int, per_page: Int) {
                self.endpoint = Endpoints.beers
                self.page = page
                self.per_page = per_page
            }
        }
        struct Response {
            var beers: [Beer]
        }
        
        struct ViewModel {
            struct DisplayedBeer {
                var image_url: String
                var name: String
                var abv: String
                var id: Int
            }
            var displayedBeers: [DisplayedBeer]
        }
    }
}
