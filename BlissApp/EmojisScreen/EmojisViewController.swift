//
//  EmojisViewController.swift
//  BlissApp
//
//  Created by Diogo on 8/9/25.
//

import UIKit
import SDWebImage

class EmojisViewController: UIViewController {
    
     let viewModel : EmojisViewModel
     let emojisView = EmojisView()
    
    init(viewModel: EmojisViewModel = EmojisViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.viewModel = EmojisViewModel()
        super.init(coder: coder)
    }
    
    override func loadView() {
        self.view = emojisView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Emojis"
        setupCollectionView()

        viewModel.getEmojisRecord { result in
            self.reloadDataCollectionView()
        }
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget		(self, action: #selector(refreshEmojis), for: .valueChanged)
        emojisView.emojisCollectionView.refreshControl = refreshControl
    }
    
    @objc func refreshEmojis() {
        viewModel.tempEmojisArray = viewModel.fetchEmojisFromCoreData()
        emojisView.emojisCollectionView.reloadData()
        emojisView.emojisCollectionView.refreshControl?.endRefreshing()
        }
    
}
		
