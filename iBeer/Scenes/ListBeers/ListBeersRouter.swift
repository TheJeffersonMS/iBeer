//
//  ListBeersRouter.swift
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

class ListBeersRouter {
    weak var viewController: ListBeersViewController?
  
    //MARK: Routing
    func routeToDetails(id:Int) {
        let main = UIStoryboard(name: "Main", bundle: nil)
        let detailBeerVC = main.instantiateViewController(withIdentifier: "DetailsBeerViewController") as? DetailsBeerViewController
        detailBeerVC?.interactor?.getBeer(request: DetailsBeer.GetBeer.Request.init(id: id))
        if let vc = detailBeerVC {
            viewController?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
