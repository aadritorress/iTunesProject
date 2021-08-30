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
        mySongs()
    }
    
    
}

extension MySongsViewController {
    private func configNavBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark.circle"), style: .plain, target: self, action: nil)
    }
}

extension MySongsViewController {
    func mySongs() {
        let nib = UINib(nibName: "MySongsCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "MySongsCell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MySongsCell") as? MySongsCell else {
            fatalError()
        }
        return cell
        }
    }
