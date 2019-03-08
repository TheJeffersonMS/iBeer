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
    func displayErrorMessage(error: Error)
}

class ListBeersViewController: UIViewController, ListBeersDisplayLogic, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var interactor: ListBeersProtocol?
    var router:ListBeersRouter?
    var displayedBeers: [ListBeers.FetchBeers.ViewModel.DisplayedBeer] = [] {
        didSet {
            tableView.isHidden = false
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        self.loadBeers()
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
        tableView.isHidden = true
    }
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedBeers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let displayedBeer = displayedBeers[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ListBeersCell") as? ListBeersCell else {
            return UITableViewCell()
        }
        cell.setCell(beer: displayedBeer)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let displayedBeer = displayedBeers[indexPath.row]
        router?.routeToDetails(id: displayedBeer.id)
    }
    
    func loadBeers() {
        interactor?.fetchBeers(request: ListBeers.FetchBeers.Request.init(page: 1, per_page: 20))
    }
    
    func displayFetchedBeers(viewModel: ListBeers.FetchBeers.ViewModel) {
        displayedBeers = viewModel.displayedBeers
    }
    
    func displayErrorMessage(error: Error) {
        let alert = UIAlertController.init(title: "Atenção!", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: "Tentar Novamente", style: .default, handler: { (action) in
            self.loadBeers()
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

