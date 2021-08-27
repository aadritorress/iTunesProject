//
//  MySongsViewController.swift
//  iTunesProject
//
//  Created by Bryan Lee on 8/27/21.
//

import UIKit

class MySongsViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "My Songs"
        configNavBar()
    }
    
    
}

extension MySongsViewController {
    private func configNavBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark.circle"), style: .plain, target: self, action: nil)
    }
}
