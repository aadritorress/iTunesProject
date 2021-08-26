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
       
        title = "Browser"
        
        configItunes()
    }

    private func configItunes() {
//        navigationItem.rightBarButtonItem = UIBarButtonItem(
//            barButtonSystemItem: .camera, target: self, action: nil
//        )
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "cart"), style: .plain, target: self, action: nil)
        
//        navigationItem.leftBarButtonItem = UIBarButtonItem(
//            barButtonSystemItem: .play, target: self, action: nil
//        )
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "music.note.list"), style: .plain, target: self, action: nil)
    }
}


