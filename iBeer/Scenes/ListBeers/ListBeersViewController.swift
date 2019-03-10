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
    private let refreshControl = UIRefreshControl()
    var displayedBeers: [ListBeers.FetchBeers.ViewModel.DisplayedBeer] = [] {
        didSet {
            tableView.isHidden = false
            refreshControl.endRefreshing()
            tableView.reloadData()
        }
    }
    var page = 1
    
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
        
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        
        refreshControl.addTarget(self, action: #selector(reloadBeers(_:)), for: .valueChanged)
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == displayedBeers.count - 1 {
            page += 1
            loadBeers()
        }
    }
    
    func loadBeers() {
        interactor?.fetchBeers(request: ListBeers.FetchBeers.Request.init(page: page, per_page: 20))
    }
    
    @objc func reloadBeers(_ sender: Any) {
        page = 1
        interactor?.refetchBeers(request: ListBeers.FetchBeers.Request.init(page: page, per_page: displayedBeers.count))
    }
    
    func displayFetchedBeers(viewModel: ListBeers.FetchBeers.ViewModel) {
        displayedBeers = viewModel.displayedBeers
    }
    
    func displayErrorMessage(error: Error) {
        var message = ""
        if error.localizedDescription == "The Internet connection appears to be offline." {
            message = "A conexão com a Internet parece estar off-line."
        } else {
            message = error.localizedDescription
        }
        
        let alert = UIAlertController.init(title: "Atenção!", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: "Tentar Novamente", style: .default, handler: { (action) in
            self.loadBeers()
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

