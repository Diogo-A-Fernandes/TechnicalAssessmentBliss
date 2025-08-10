//
//  HomeScreenViewController.swift
//  BlissApp
//
//  Created by Diogo on 8/7/25.
//

import UIKit
import SDWebImage

class HomeScreenViewController: UIViewController {

    private var homeView = HomeScreenView()
    private var viewModel: HomeScreenViewModel
    
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
        title = "Main Screen"
        homeView.randomEmojiButton.addTarget(self, action: #selector(randomEmojiButtonGotTapped), for: .touchUpInside)
    }
    
    @objc func randomEmojiButtonGotTapped(_ sender: UIButton) {
        viewModel.getEmojisRecord { [weak self] emojis in
            guard let self = self else { return }
            guard let emoji = emojis, let imageUrlString = emoji.image, let imageUrl = URL(string: imageUrlString) else {
                
                DispatchQueue.main.async {
                    self.homeView.randomEmojiImageView.image = UIImage(named: "placeholder")
                }
                return
            }
            
            DispatchQueue.main.async {
                self.homeView.randomEmojiImageView.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "placeholder"))
            }
        }
    }
}
