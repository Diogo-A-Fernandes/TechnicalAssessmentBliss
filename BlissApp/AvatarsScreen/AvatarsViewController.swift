//
//  AvatarsViewController.swift
//  BlissApp
//
//  Created by Diogo on 8/16/25.
//

import UIKit

class AvatarsViewController: UIViewController {
    
    let viewModel: AvatarsViewModel
    let avatarsView = AvatarsView()
    
    init(viewModel: AvatarsViewModel = AvatarsViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.viewModel = AvatarsViewModel()
        super.init(coder: coder)
    }
    
    override func loadView() {
        self.view = avatarsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Avatars"
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchAvatarsAndReload()
    }
    
    private func fetchAvatarsAndReload() {
        viewModel.fetchAvatars { [weak self] _ in
            self?.reloadDataCollectionView()
        }
    }
}
