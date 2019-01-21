//
//  ViewController.swift
//  iBeer
//
//  Created by Jefferson Martins de Sá on 20/01/2019.
//  Copyright © 2019 Jefferson Martins de Sá. All rights reserved.
//

import UIKit

protocol ListBeersDisplayLogic: class {
    func displayFetchedBeers(viewModel: ListBeers.FetchBeers.ViewModel)
}

class ListBeersViewController: UIViewController, ListBeersDisplayLogic, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var interactor: ListBeersProtocol?
    var router:ListBeersRouter?
    var displayedBeers: [ListBeers.FetchBeers.ViewModel.DisplayedBeer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        interactor?.fetchBeers(request: ListBeers.FetchBeers.Request.init(page: 1, per_page: 20))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func setup() {
        let viewController = self
        viewController.title = "Beers"
        let interactor = ListBeersInteractor()
        let presenter = ListBeersPresenter()
        let router = ListBeersRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
    }
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedBeers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let displayedBeer = displayedBeers[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListBeersCell") as! ListBeersCell
        cell.setCell(beer: displayedBeer)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let displayedBeer = displayedBeers[indexPath.row]
        router?.routeToDetails(id: displayedBeer.id)
    }
    
    func displayFetchedBeers(viewModel: ListBeers.FetchBeers.ViewModel) {
        displayedBeers = viewModel.displayedBeers
        tableView.reloadData()
    }
}

