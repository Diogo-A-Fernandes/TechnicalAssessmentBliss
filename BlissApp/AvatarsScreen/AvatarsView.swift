//
//  AvatarsView.swift
//  BlissApp
//
//  Created by Diogo on 8/16/25.
//

import UIKit

class AvatarsView: UIView {
    
    var avatarsCollectionView : GridCollectionView = GridCollectionView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setUpLayout(){
        
        addSubview(avatarsCollectionView)
        
        NSLayoutConstraint.activate([
            avatarsCollectionView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            avatarsCollectionView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor,constant: 10),
            avatarsCollectionView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor,constant: -10),
            avatarsCollectionView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
