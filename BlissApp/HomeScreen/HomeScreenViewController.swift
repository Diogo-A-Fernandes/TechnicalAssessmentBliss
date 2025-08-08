//
//  HomeScreenViewController.swift
//  BlissApp
//
//  Created by Diogo on 8/7/25.
//

import UIKit

class HomeScreenViewController: UIViewController{
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = "Main Screen"
        configurarLabel()
    }
    
    private func configurarLabel() {
        let label = UILabel()
        label.text = "Hello"
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            label.widthAnchor.constraint(equalToConstant: 200),
            label.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    
}
