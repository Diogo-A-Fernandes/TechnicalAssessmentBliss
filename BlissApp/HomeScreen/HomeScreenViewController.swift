//
//  HomeScreenViewController.swift
//  BlissApp
//
//  Created by Diogo on 8/7/25.
//

import UIKit

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
        viewModel.getEmojisRecord { emojis in
        }
    }
}
