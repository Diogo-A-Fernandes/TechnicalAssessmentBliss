//
//  RepositoriesViewController.swift
//  BlissApp
//
//  Created by Diogo on 8/18/25.
//

import UIKit
import SDWebImage

class RepositoriesViewController: UIViewController {
    
    let viewModel: RepositoriesViewModel
    let repositoriesView = RepositoriesView()
    
    init(viewModel: RepositoriesViewModel = RepositoriesViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.viewModel = RepositoriesViewModel()
        super.init(coder: coder)
    }
    
    override func loadView() {
        self.view = repositoriesView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Apple Repositories"
        setupTableView()
        bindLoading()
        
        viewModel.getRepositoriesRecord { [weak self] _ in
            DispatchQueue.main.async {
                self?.repositoriesView.repositoriesTableView.reloadData()
            }
        }
    }
    
    private func bindLoading() {
        viewModel.isLoading.bind { [weak self] loading in
            guard let self = self else { return }
            if loading == true {
                self.repositoriesView.showSpinner()
            } else {
                self.repositoriesView.hideSpinner()
            }
        }
    }
}
