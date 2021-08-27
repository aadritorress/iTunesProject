//
//  CartViewController.swift
//  iTunesProject
//
//  Created by Bryan Lee on 8/26/21.
//

import UIKit

class CartViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Cart"
        configNavBar()
        
    }
    
}

extension CartViewController {
    private func configNavBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Buy", style: .plain, target: self, action: nil)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Browse", style: .plain, target: self, action: nil)
    }
    
}


    
    

