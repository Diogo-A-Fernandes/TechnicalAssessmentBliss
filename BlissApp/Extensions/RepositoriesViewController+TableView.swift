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
        cell.configure(text: repo.name ?? "Unnamed repo")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
           if indexPath.row == viewModel.tempReposArray.count - 1 {
               viewModel.loadMore { [weak self] _ in
                   DispatchQueue.main.async {
                       self?.repositoriesView.repositoriesTableView.reloadData()
                   }
               }
           }
       }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let frameHeight = scrollView.frame.size.height
        
        if offsetY > contentHeight - frameHeight - 100 {
            viewModel.getRepositoriesRecord { [weak self] _ in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    self.repositoriesView.repositoriesTableView.reloadData()
                }
            }
        }
    }
}
