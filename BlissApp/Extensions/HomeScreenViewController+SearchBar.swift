//
//  HomeScreenViewController+SearchBar.swift
//  BlissApp
//
//  Created by Diogo on 8/16/25.
//

import UIKit

extension HomeScreenViewController: UISearchBarDelegate {
    
    func setupSearchBar() {
        homeView.searchBar.delegate = self
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if !searchText.isEmpty {
            searchBar.layer.borderColor = UIColor.clear.cgColor
            searchBar.layer.borderWidth = 0
        }
        
        viewModel.lastSearchText = searchText
    }
    
}
