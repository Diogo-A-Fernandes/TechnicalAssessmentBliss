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
    let spinner = UIActivityIndicatorView(style: .large)
    let warningLabel = UILabel()
    
    
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
        
        spinner.hidesWhenStopped = true
        spinner.color = .gray
        spinner.translatesAutoresizingMaskIntoConstraints = false
        
        warningLabel.textColor = .red
        warningLabel.font = UIFont.systemFont(ofSize: 14)
        warningLabel.textAlignment = .center
        warningLabel.isHidden = true
        
        randomEmojiImageView.image = UIImage(systemName: "person.fill")
        randomEmojiImageView.contentMode = .scaleAspectFit
        randomEmojiImageView.tintColor = .gray
        
        randomEmojiButton.backgroundColor = .gray
        randomEmojiButton.setTitle("Random Emoji", for: .normal)
        
        emojisListButton.backgroundColor = .gray
        emojisListButton.setTitle("Emojis List", for: .normal)
        
        searchBar.placeholder = "Search"
        searchBar.searchBarStyle = .minimal
        searchBar.setImage(UIImage(), for: .search, state: .normal)
        
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
            randomEmojiButton,
            emojisListButton,
            horizontalStack,
            warningLabel,
            avatarsListButton,
            repositoriesButton
        ])
        homeScreenStack.axis = .vertical
        homeScreenStack.spacing = 8
        homeScreenStack.translatesAutoresizingMaskIntoConstraints = false
        
        randomEmojiImageView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(randomEmojiImageView)
        addSubview(homeScreenStack)
        addSubview(spinner)
        
        NSLayoutConstraint.activate([
            randomEmojiImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5),
            randomEmojiImageView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            randomEmojiImageView.widthAnchor.constraint(equalToConstant: 100),
            randomEmojiImageView.heightAnchor.constraint(equalToConstant: 100),
            
            homeScreenStack.topAnchor.constraint(equalTo: randomEmojiImageView.bottomAnchor, constant: 5),
            homeScreenStack.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            homeScreenStack.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            spinner.centerXAnchor.constraint(equalTo: randomEmojiImageView.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: randomEmojiImageView.centerYAnchor)
        ])
    }
    
    func setupSearchBarWarning(){
        
        searchBar.layer.borderColor = CGColor(red: 1, green: 0, blue: 0, alpha: 1)
        searchBar.layer.borderWidth = 1.5
        searchBar.layer.cornerRadius = 8
    }
    
    func showSpinner() {
        spinner.startAnimating()
    }
    
    func hideSpinner() {
        spinner.stopAnimating()
    }
    
    func showWarningLabel(_ text: String) {
        warningLabel.text = text
        warningLabel.isHidden = false
    }
    
    func hideWarningLabel() {
        warningLabel.isHidden = true
    }
    
}
