//
//  EmojisView.swift
//  BlissApp
//
//  Created by Diogo on 8/9/25.
//

import UIKit

class EmojisView: UIView {
    
    var emojisCollectionView : GridCollectionView = GridCollectionView()
    let spinner = UIActivityIndicatorView(style: .large)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setUpLayout(){
        
        spinner.hidesWhenStopped = true
        spinner.color = .gray
        spinner.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(emojisCollectionView)
        addSubview(spinner)
        
        NSLayoutConstraint.activate([
            emojisCollectionView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            emojisCollectionView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor,constant: 10),
            emojisCollectionView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor,constant: -10),
            emojisCollectionView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            
            spinner.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor)
        ])
    }
    
    func showSpinner() {
        spinner.startAnimating()
    }
    
    func hideSpinner() {
        spinner.stopAnimating()
    }
}
