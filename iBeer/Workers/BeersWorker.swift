//
//  BeersWorker.swift
//  iBeer
//
//  Created by Jefferson Martins de Sá on 20/01/2019.
//  Copyright © 2019 Jefferson Martins de Sá. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class BeersWorker {
    
    init() {
        
    }
    
    func fetchBeers(request: ListBeers.FetchBeers.Request, completionSuccess: @escaping ([Beer])-> Void, completionFailure:@escaping (Error?)-> Void) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let url = "\(request.endpoint)?page=\(request.page)&per_page=\(request.per_page)"
        Alamofire.request(url).validate().responseArray { (response: DataResponse<[Beer]>) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            print("\nResquest: \(request) \n\nResponse: \(response.result.value?.toJSONString() ?? "")")
            if let result = response.result.value {
                completionSuccess(result)
            } else {
                completionFailure(response.error)
            }
            
        }
    }
    
    func getBeer(request: DetailsBeer.GetBeer.Request, completionSuccess: @escaping (Beer)-> Void, completionFailure:@escaping (Error?)-> Void) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let url = "\(request.endpoint)/\(request.id)"
        Alamofire.request(url).validate().responseArray { (response: DataResponse<[Beer]>) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            print("\nResquest: \(request) \n\nResponse: \(response.result.value?.toJSONString() ?? "")")
            if let result = response.result.value?.first {
                completionSuccess(result)
            } else {
                completionFailure(response.error)
            }
            
        }
    }
}
