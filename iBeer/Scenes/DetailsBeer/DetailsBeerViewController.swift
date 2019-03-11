//
//  DetailsBeerViewController.swift
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
import Alamofire

protocol DetailsBeerDisplayLogic: class {
    func displayDetailsBeer(viewModel: DetailsBeer.GetBeer.ViewModel)
    func displayErrorMessage(error: Error)
}

class DetailsBeerViewController: UIViewController, DetailsBeerDisplayLogic {
   
    @IBOutlet weak var beerImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var taglineLabel: UILabel!
    @IBOutlet weak var abvLabel: UILabel!
    @IBOutlet weak var ibuLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var interactor: DetailsBeerBusinessLogic?
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = DetailsBeerInteractor()
        let presenter = DetailsBeerPresenter()
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func displayDetailsBeer(viewModel: DetailsBeer.GetBeer.ViewModel) {
        
        if let url = URL(string: viewModel.displayedBeer.image_url) {
            Alamofire.request(url, method: .get).validate().responseData { (responseData) in
                if let data = responseData.data {
                    self.beerImageView.image = UIImage(data: data)
                    DispatchQueue.main.async {
                        self.beerImageView.setNeedsLayout()
                        self.beerImageView.backgroundColor = UIColor.clear
                    }
                }
            }
        }
        
        self.nameLabel.text = viewModel.displayedBeer.name
        self.title = viewModel.displayedBeer.name
        self.taglineLabel.text = "Tagline: \(viewModel.displayedBeer.tagline)"
        self.abvLabel.text = "abv: \(viewModel.displayedBeer.abv)"
        self.ibuLabel.text = "ibu: \(viewModel.displayedBeer.ibu)"
        self.descriptionLabel.text = "description: \(viewModel.displayedBeer.description)"
        
        self.nameLabel.backgroundColor = UIColor.clear
        self.taglineLabel.backgroundColor = UIColor.clear
        self.abvLabel.backgroundColor = UIColor.clear
        self.ibuLabel.backgroundColor = UIColor.clear
        self.descriptionLabel.backgroundColor = UIColor.clear
    }
    
    func displayErrorMessage(error: Error) {
        
        let alert = UIAlertController.init(title: "Atenção!", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: "Voltar", style: .default, handler: { (action) in
            self.navigationController?.popViewController(animated: true)
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
