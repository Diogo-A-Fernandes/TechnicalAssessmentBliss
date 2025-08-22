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
        emojisView.emojisCollectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.reuseIdentifier)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = viewModel.tempEmojisArray.count
        
        if count == 0 {
            collectionView.setEmptyMessage("No emojis avaliable at the moment.")
        } else {
            collectionView.restore()
        }
        
        return count
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.reuseIdentifier, for: indexPath) as? ImageCollectionViewCell else {
            fatalError("Could not dequeue EmojiCollectionViewCell")
        }
        
        let emoji = viewModel.tempEmojisArray[indexPath.item]
        
        if let urlString = emoji.image, let url = URL(string: urlString) {
            cell.configure(url: url)
        } else {
            cell.imageView.image = UIImage(systemName: "person.fill")
            cell.imageView.contentMode = .scaleAspectFit
            cell.imageView.tintColor = .gray
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
            viewModel.tempEmojisArray.remove(at: indexPath.item)

            collectionView.deleteItems(at: [indexPath])
        }
    
    func reloadDataCollectionView() {
        
        DispatchQueue.main.async {
            self.emojisView.emojisCollectionView.reloadData()
        }
        
    }
}
