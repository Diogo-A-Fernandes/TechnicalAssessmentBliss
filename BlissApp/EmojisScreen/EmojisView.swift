//
//  EmojisView.swift
//  BlissApp
//
//  Created by Diogo on 8/9/25.
//

import UIKit

class EmojisView: UIView {
    
    var emojisCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 80, height: 80) // tamanho das células
        layout.minimumLineSpacing = 10  // espaçamento vertical
        layout.minimumInteritemSpacing = 10 // espaçamento horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
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
