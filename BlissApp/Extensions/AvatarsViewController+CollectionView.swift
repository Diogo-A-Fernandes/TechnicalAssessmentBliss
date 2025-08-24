//
//  AvatarsViewController+CollectionView.swift
//  BlissApp
//
//  Created by Diogo on 8/17/25.
//

import UIKit
import SDWebImage

extension AvatarsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func setupCollectionView() {
        avatarsView.avatarsCollectionView.delegate = self
        avatarsView.avatarsCollectionView.dataSource = self
        registerCells()
    }
    
    func registerCells() {
        avatarsView.avatarsCollectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.reuseIdentifier)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = viewModel.numberOfItems()
        
        if count == 0 {
            collectionView.setEmptyMessage("No avatars stored at the moment.")
        } else {
            collectionView.restore()
        }
        
        return count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.reuseIdentifier, for: indexPath) as? ImageCollectionViewCell else {
            fatalError("Could not dequeue ImageCollectionViewCell")
        }
        
        let avatars = viewModel.getAvatars()
        let avatar = avatars[indexPath.row]
        
        if let urlString = avatar.image, let url = URL(string: urlString) {
            cell.configure(url: url)
        } else {
            cell.imageView.image = UIImage(systemName: "person.fill")
            cell.imageView.contentMode = .scaleAspectFit
            cell.imageView.tintColor = .gray
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let avatars = viewModel.getAvatars()
        let selectedAvatar = avatars[indexPath.item]
        
        if viewModel.deleteAvatars(avatar: selectedAvatar, index: indexPath.item) {
            collectionView.deleteItems(at:  [indexPath])
        }
    }
    
    func reloadDataCollectionView() {
        
        DispatchQueue.main.async {
            self.avatarsView.avatarsCollectionView.reloadData()
        }
        
    }
}
