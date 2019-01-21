//
//  ListBeersInteractor.swift
//  iBeer
//
//  Created by Jefferson Martins de Sá on 20/01/2019.
//  Copyright (c) 2019 Jefferson Martins de Sá. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol ListBeersProtocol {
  func fetchBeers(request: ListBeers.FetchBeers.Request)
}

class ListBeersInteractor: ListBeersProtocol {
  var presenter: ListBeersPresentationLogic?
  var worker: BeersWorker?
  
  // MARK: requests
  
  func fetchBeers(request: ListBeers.FetchBeers.Request) {
    worker = BeersWorker()
    worker?.fetchBeers(request: request, completionSuccess: { (response) in
        let response = ListBeers.FetchBeers.Response(beers: response)
        self.presenter?.presentListBeers(response: response)
    }, completionFailure: { (error) in
        // to do error 
    })
  }
}
