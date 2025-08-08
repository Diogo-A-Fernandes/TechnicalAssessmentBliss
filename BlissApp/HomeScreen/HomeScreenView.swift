//
//  HomeScreenView.swift
//  BlissApp
//
//  Created by Diogo on 8/8/25.
//

import UIKit

class HomeScreenView: UIView {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpVerticalStack()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpVerticalStack()
    }
    
    private func setUpVerticalStack() {
        
        let homeScreenStack = UIStackView(arrangedSubviews: setupSubviewsForVerticalStack())
        homeScreenStack.axis = .vertical
        homeScreenStack.spacing = 8
        homeScreenStack.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(homeScreenStack)
        
        
        NSLayoutConstraint.activate([
            homeScreenStack.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            homeScreenStack.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            homeScreenStack.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9)
        ])
    }
    
    private func setupSubviewsForVerticalStack() -> [UIView]{
        
        let randomEmojiImageView = UIImageView()
        randomEmojiImageView.backgroundColor = .gray
        randomEmojiImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        let randomEmojiButton = UIButton()
        randomEmojiButton.backgroundColor = .gray
        randomEmojiButton.setTitle("Random Emoji", for: .normal)
        
        let emojisListButton = UIButton()
        emojisListButton.backgroundColor = .gray
        emojisListButton.setTitle("Emojis List", for: .normal)
        
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search"
        searchBar.searchBarStyle = .minimal
        
        let searchButton = UIButton()
        searchButton.backgroundColor = .gray
        searchButton.setTitle("Search", for: .normal)
        
        let horizontalStack = UIStackView(arrangedSubviews: [searchBar
                                                             ,searchButton])
        horizontalStack.axis = .horizontal
        
        let avatarsListButton = UIButton()
        avatarsListButton.backgroundColor = .gray
        avatarsListButton.setTitle("Avatars List", for: .normal)
        
        let repositoriesButton = UIButton()
        repositoriesButton.backgroundColor = .gray
        repositoriesButton.setTitle("Apple Repos", for: .normal)
        
        return [randomEmojiImageView,randomEmojiButton,emojisListButton,horizontalStack,avatarsListButton,repositoriesButton]
    }
    
}
