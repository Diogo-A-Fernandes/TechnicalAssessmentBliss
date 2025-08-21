//
//  HomeScreenViewController.swift
//  BlissApp
//
//  Created by Diogo on 8/7/25.
//

import UIKit
import SDWebImage

class HomeScreenViewController: UIViewController {

    let homeView = HomeScreenView()
    let viewModel: HomeScreenViewModel
    private let emojisScreen = EmojisViewController()
    private let avatarsScreen = AvatarsViewController()
    private let reposScreen = RepositoriesViewController()
    
    init(viewModel: HomeScreenViewModel = HomeScreenViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        self.viewModel = HomeScreenViewModel()
        super.init(coder: coder)
    }

    override func loadView() {
        self.view = homeView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Home Screen"
        setupSearchBar()

        homeView.randomEmojiButton.addTarget(self, action: #selector(randomEmojiButtonGotTapped), for: .touchUpInside)
        homeView.emojisListButton.addTarget(self,action: #selector(emojiListButtonGotTapped), for: .touchUpInside)
        homeView.searchButton.addTarget(self, action: #selector(searchButtonGotTapped), for: .touchUpInside)
        homeView.avatarsListButton.addTarget(self, action: #selector(avatarsListButtonGotTapped), for: .touchUpInside)
        homeView.repositoriesButton.addTarget(self, action: #selector(repositoriesButtonGotTapped), for: .touchUpInside)
    }
    
    @objc func randomEmojiButtonGotTapped(_ sender: UIButton) {
        viewModel.getEmojisRecord { [weak self] emojis in
            guard let self = self else { return }
            
            if let emoji = emojis, let imageUrlString = emoji.image, let imageUrl = URL(string: imageUrlString) {
                DispatchQueue.main.async {
                    self.homeView.randomEmojiImageView.sd_setImage(with: imageUrl)
                }
            }
        }
    }

    
    @objc func emojiListButtonGotTapped(_ sender: UIButton) {
        
        if let navigationController = self.navigationController {
            navigationController.pushViewController(emojisScreen, animated: true)
        }
    }
    
    @objc func searchButtonGotTapped(_ sender: UIButton) {
       
        guard let text = viewModel.lastSearchText, !text.isEmpty else {
            homeView.setupSearchBarWarning()
            return
        }
        
        viewModel.getAvatarRecord(username: text) { [weak self] avatar in
            
            guard let self = self else { return }
            
            guard let urlString = avatar?.image, let imageUrl = URL(string: urlString) else {
                DispatchQueue.main.async {
                    self.homeView.randomEmojiImageView.image = UIImage(systemName: "person.fill")
                    self.homeView.randomEmojiImageView.tintColor = .gray
                    self.homeView.randomEmojiImageView.contentMode = .scaleAspectFit
                }
                return
            }
            
            DispatchQueue.main.async {
                self.homeView.randomEmojiImageView.sd_setImage(with: imageUrl)
            }
        }
    }

    @objc func avatarsListButtonGotTapped(_ sender: UIButton) {
        
        if let navigationController = self.navigationController {
            navigationController.pushViewController(avatarsScreen, animated: true)
        }
    }
    
    @objc func repositoriesButtonGotTapped(_ sender: UIButton) {
        
        if let navigationController = self.navigationController {
            navigationController.pushViewController(reposScreen, animated: true)
        }
    }
}
