//
//  EmojisViewController+TableView.swift
//  BlissApp
//
//  Created by Diogo on 8/11/25.
//

import UIKit

extension EmojisViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func setupCollectionView() {
        emojisView.emojisCollectionView.delegate = self
        emojisView.emojisCollectionView.dataSource = self
        registerCells()
    }
    
    func registerCells(){
        emojisView.emojisCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = .systemBlue 
        return cell
        
    }
    
    
    
    
}
