//
//  Beer.swift
//  iBeer
//
//  Created by Jefferson Martins de Sá on 20/01/2019.
//  Copyright © 2019 Jefferson Martins de Sá. All rights reserved.
//

import Foundation
import ObjectMapper
import AlamofireObjectMapper
import Alamofire

class Beer: Mappable {
    
    var id: Int?
    var image_url: String?
    var name: String?
    var abv: Double?
    var tagline: String?
    var ibu: Int?
    var description: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        image_url <- map["image_url"]
        name <- map["name"]
        abv <- map["abv"]
        tagline <- map["tagline"]
        ibu <- map["ibu"]
        description <- map["description"]
    }

}
