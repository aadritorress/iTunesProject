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
        myPurchases()
    }
    
}

extension CartViewController {
    private func configNavBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Buy", style: .plain, target: self, action: nil)
    }
}



extension CartViewController {
    func myPurchases() {
        let nib = UINib(nibName: "TitleViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "TitleViewCell")
        
        let nib2 = UINib(nibName: "NumberItemsCell", bundle: nil)
        tableView.register(nib2, forCellReuseIdentifier: "NumberItemsCell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "NumberItemsCell") as? NumberItemsCell else {
                fatalError()
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TitleViewCell", for: indexPath) as! TitleViewCell
            return cell
        }
    }
}


