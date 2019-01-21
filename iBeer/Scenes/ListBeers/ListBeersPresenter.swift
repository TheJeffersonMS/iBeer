//
//  ListBeersPresenter.swift
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

protocol ListBeersPresentationLogic {
  func presentListBeers(response: ListBeers.FetchBeers.Response)
}

class ListBeersPresenter: ListBeersPresentationLogic {
  weak var viewController: ListBeersDisplayLogic?
  
  // MARK: presentListBeers
  
  func presentListBeers(response: ListBeers.FetchBeers.Response) {
    
    var displayedBeers: [ListBeers.FetchBeers.ViewModel.DisplayedBeer] = []
    for beer in response.beers {
        if let image_url = beer.image_url, let name = beer.name, let abv = beer.abv, let id = beer.id {
            let displayedBeer = ListBeers.FetchBeers.ViewModel.DisplayedBeer.init(image_url: image_url, name: name, abv: "\(abv)", id: id)
            displayedBeers.append(displayedBeer)
        }
    }
    let viewModel = ListBeers.FetchBeers.ViewModel(displayedBeers: displayedBeers)
    viewController?.displayFetchedBeers(viewModel: viewModel)
  }
}