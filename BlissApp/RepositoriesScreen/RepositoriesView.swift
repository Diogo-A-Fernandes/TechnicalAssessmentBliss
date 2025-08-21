//
//  RepositoriesView.swift
//  BlissApp
//
//  Created by Diogo on 8/18/25.
//

import UIKit

class RepositoriesView: UIView {
    
    let repositoriesTableView = UITableView()
    let spinner = UIActivityIndicatorView(style: .medium)

    private lazy var footerView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 50))
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.hidesWhenStopped = true
        view.addSubview(spinner)
        
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpLayout()
        setUpSpinner()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpLayout()
        setUpSpinner()
    }
    
    private func setUpLayout() {
        repositoriesTableView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(repositoriesTableView)
        
        NSLayoutConstraint.activate([
            repositoriesTableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            repositoriesTableView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor),
            repositoriesTableView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor),
            repositoriesTableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setUpSpinner() {
        repositoriesTableView.tableFooterView = footerView
    }
    
    func showSpinner() {
        spinner.startAnimating()
    }
    
    func hideSpinner() {
        spinner.stopAnimating()
    }
}
