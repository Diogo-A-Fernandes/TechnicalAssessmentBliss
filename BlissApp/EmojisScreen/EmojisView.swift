//
//  EmojisView.swift
//  BlissApp
//
//  Created by Diogo on 8/9/25.
//

import UIKit

class EmojisView: UIView {
    
    let emojisTableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setUpLayout(){
        
        emojisTableView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(emojisTableView)
        
        NSLayoutConstraint.activate([
            emojisTableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            emojisTableView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor),
            emojisTableView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor),
            emojisTableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
