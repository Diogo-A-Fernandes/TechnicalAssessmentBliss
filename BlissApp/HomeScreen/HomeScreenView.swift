//
//  HomeScreenView.swift
//  BlissApp
//
//  Created by Diogo on 8/8/25.
//

import UIKit

class HomeScreenView: UIView {
    
    let randomEmojiImageView = UIImageView()
    let randomEmojiButton = UIButton()
    let emojisListButton = UIButton()
    let searchBar = UISearchBar()
    let searchButton = UIButton()
    let avatarsListButton = UIButton()
    let repositoriesButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSubviews()
        buildVerticalStack()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureSubviews()
        buildVerticalStack()
    }
    
    private func configureSubviews() {

        randomEmojiImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        randomEmojiButton.backgroundColor = .gray
        randomEmojiButton.setTitle("Random Emoji", for: .normal)
        
        emojisListButton.backgroundColor = .gray
        emojisListButton.setTitle("Emojis List", for: .normal)
        
        searchBar.placeholder = "Search"
        searchBar.searchBarStyle = .minimal
        
        searchButton.backgroundColor = .gray
        searchButton.setTitle("Search", for: .normal)
        
        avatarsListButton.backgroundColor = .gray
        avatarsListButton.setTitle("Avatars List", for: .normal)
        
        repositoriesButton.backgroundColor = .gray
        repositoriesButton.setTitle("Apple Repos", for: .normal)
    }
    
    private func buildVerticalStack() {
        let horizontalStack = UIStackView(arrangedSubviews: [searchBar, searchButton])
        horizontalStack.axis = .horizontal
        horizontalStack.spacing = 8
        
        let homeScreenStack = UIStackView(arrangedSubviews: [
            randomEmojiImageView,
            randomEmojiButton,
            emojisListButton,
            horizontalStack,
            avatarsListButton,
            repositoriesButton
        ])
        homeScreenStack.axis = .vertical
        homeScreenStack.spacing = 8
        homeScreenStack.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(homeScreenStack)
        
        NSLayoutConstraint.activate([
            homeScreenStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            homeScreenStack.centerYAnchor.constraint(equalTo: centerYAnchor),
            homeScreenStack.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9)
        ])
    }
}
