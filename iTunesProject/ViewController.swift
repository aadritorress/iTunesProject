//
//  ViewController.swift
//  iTunesProject
//
//  Created by Adri Torres on 8/26/21.
//

import UIKit

class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
        title = "Browse"
        configureTableView()
        
        configItunes()
    }

    private func configItunes() {
//        navigationItem.rightBarButtonItem = UIBarButtonItem(
//            barButtonSystemItem: .camera, target: self, action: nil
//        )
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "cart"), style: .plain, target: self, action: #selector(cartClicked))
        
//        navigationItem.leftBarButtonItem = UIBarButtonItem(
//            barButtonSystemItem: .play, target: self, action: nil
//        )
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "music.note.list"), style: .plain, target: self, action: #selector(mySongsClicked))
    }
}

extension ViewController {
    func configureTableView() {
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "TableViewCell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as? TableViewCell else {
            fatalError()
        }
        return cell
    }
    
    @objc func cartClicked() {
        let storyboard = UIStoryboard(name: "CartViewStoryboard", bundle: nil)
        
        guard let cartVC = storyboard.instantiateInitialViewController() as? CartViewController else {
            assertionFailure("Could not instantiate CartViewController")
            return
        }
        navigationController?.pushViewController(cartVC, animated: true)
        
    }
    
    @objc func mySongsClicked() {
        let storyboard = UIStoryboard(name: "MySongsStoryboard", bundle: nil)
        
        guard let mySongsVC = storyboard.instantiateInitialViewController() as? MySongsViewController else {
            assertionFailure("Could not instantiate MySongsController")
            return
        }
        navigationController?.pushViewController(mySongsVC, animated: true)
    }
}

