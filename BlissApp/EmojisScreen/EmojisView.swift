//
//  EmojisView.swift
//  BlissApp
//
//  Created by Diogo on 8/9/25.
//

import UIKit

class EmojisView: UIView {
    
    var emojisCollectionView : GridCollectionView = GridCollectionView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setUpLayout(){
        
        addSubview(emojisCollectionView)
        
        NSLayoutConstraint.activate([
            emojisCollectionView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            emojisCollectionView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor,constant: 10),
            emojisCollectionView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor,constant: -10),
            emojisCollectionView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
