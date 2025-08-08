//
//  HomeScreenView.swift
//  BlissApp
//
//  Created by Diogo on 8/8/25.
//

import UIKit

class HomeScreenView: UIView {
    
    override init(frame: CGRect) {
           super.init(frame: frame)
           setupViews()
       }
       
       required init?(coder: NSCoder) {
           super.init(coder: coder)
           setupViews()
       }
    
    private func setupViews() {
        let label = UILabel()
        label.text = "Hello"
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            label.widthAnchor.constraint(equalToConstant: 200),
            label.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
}
