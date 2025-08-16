//
//  EmojisViewController+TableView.swift
//  BlissApp
//
//  Created by Diogo on 8/11/25.
//

import UIKit
import SDWebImage

extension EmojisViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func setupCollectionView() {
        emojisView.emojisCollectionView.delegate = self
        emojisView.emojisCollectionView.dataSource = self
        registerCells()
    }
    
    func registerCells() {
        emojisView.emojisCollectionView.register(EmojiCollectionViewCell.self, forCellWithReuseIdentifier: EmojiCollectionViewCell.reuseIdentifier)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItems()
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmojiCollectionViewCell.reuseIdentifier, for: indexPath) as? EmojiCollectionViewCell else {
            fatalError("Could not dequeue EmojiCollectionViewCell")
        }
        
        let emoji = viewModel.tempEmojisArray[indexPath.item]
        
        if let urlString = emoji.image, let url = URL(string: urlString) {
            cell.imageView.sd_setImage(with: url)
        } else {
            cell.imageView.image = nil
        }
        return cell
    }

    func reloadDataCollectionView() {
        
        DispatchQueue.main.async {
            self.emojisView.emojisCollectionView.reloadData()
        }
        
    }
}
