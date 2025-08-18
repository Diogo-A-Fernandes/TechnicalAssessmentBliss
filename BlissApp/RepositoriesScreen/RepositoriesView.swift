//
//  RepositoriesView.swift
//  BlissApp
//
//  Created by Diogo on 8/18/25.
//

import UIKit

class RepositoriesView: UIView {
    
     let repositoriesTableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setUpLayout(){
        
        repositoriesTableView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(repositoriesTableView)
        
        NSLayoutConstraint.activate([
            repositoriesTableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            repositoriesTableView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor),
            repositoriesTableView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor),
            repositoriesTableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
