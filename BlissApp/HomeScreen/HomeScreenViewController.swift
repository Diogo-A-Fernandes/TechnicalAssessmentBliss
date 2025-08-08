//
//  HomeScreenViewController.swift
//  BlissApp
//
//  Created by Diogo on 8/7/25.
//

import UIKit

class HomeScreenViewController: UIViewController{
    
    private var homeView = HomeScreenView()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        self.view = homeView
        view.backgroundColor = .white
        self.title = "Main Screen"
    }
    
}
