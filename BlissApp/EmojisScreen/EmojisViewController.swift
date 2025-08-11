//
//  EmojisViewController.swift
//  BlissApp
//
//  Created by Diogo on 8/9/25.
//

import UIKit

class EmojisViewController: UIViewController {
    
    private let viewModel : EmojisViewModel
    private let emojisView = EmojisView()
    
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
        title = "Emojis List"
        emojisView.emojisTableView.backgroundColor = .red
    }
}
