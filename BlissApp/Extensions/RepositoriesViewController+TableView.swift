//
//  RepositoriesViewController+TableView.swift
//  BlissApp
//
//  Created by user284977 on 8/18/25.
//

import UIKit

extension RepositoriesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func setupTableView() {
        repositoriesView.repositoriesTableView.delegate = self
        repositoriesView.repositoriesTableView.dataSource = self
        registerCells()
    }
    
    func registerCells() {
        repositoriesView.repositoriesTableView.register(TextTableViewCell.self, forCellReuseIdentifier: TextTableViewCell.reuseIdentifier)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TextTableViewCell.reuseIdentifier, for: indexPath) as? TextTableViewCell else {
                return UITableViewCell()
            }

        let repo = viewModel.tempReposArray[indexPath.row]

        if let name = repo.name {
            cell.configure(text: name)
        } else {
            cell.configure(text: "Unnamed repo")
        }
        
            return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

}
