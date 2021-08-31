//
//  MySongsViewController.swift
//  iTunesProject
//
//  Created by Bryan Lee on 8/27/21.
//

import UIKit

class MySongsViewController: UITableViewController {
    
    var purchases: [AlbumInfo] = []
    var cartTotal: [AlbumInfo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "My Songs"
        configNavBar()
        mySongs()
        fetchMySongs()
    }
}

extension MySongsViewController {
    private func configNavBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark.circle"), style: .plain, target: self, action: #selector(xButtonClicked))
    }
}

extension MySongsViewController {
    func fetchMySongs() {
        let cacheDirectory = FileManager.SearchPathDirectory.cachesDirectory
                let folderUrls = FileManager.default.urls(for: cacheDirectory, in: .userDomainMask)
                
                guard let fileURL = folderUrls.first?.appendingPathComponent("songs") else {
                    fatalError()
                }
                guard let newData = FileManager.default.contents(atPath: fileURL.path) else {
                    fatalError()
        //            throw DiskStorageError.noData
                }
                do {
                    let object = try JSONDecoder().decode([AlbumInfo].self, from: newData)
                    purchases = object
//                    print(purchases)
//                    let songName = purchases.map { (song) -> String in
//                        song.collectionName
//                    }
//                    print(songName)
//
                    tableView.reloadData()
                } catch {
                    fatalError()
                }
            }
    
    @objc func xButtonClicked() {
        let cacheDirectory = FileManager.SearchPathDirectory.cachesDirectory
        let folderUrls = FileManager.default.urls(for: cacheDirectory, in: .userDomainMask)
        guard let fileURL = folderUrls.first?.appendingPathComponent("songs") else {
            fatalError()
        }
        self.purchases = []
        guard let data = try? JSONEncoder().encode(self.purchases) else {
            fatalError()
        }
        do {
            try data.write(to: fileURL)
        } catch {
            fatalError()
        }
        self.tableView.reloadData()
    }
    
    
    }


extension MySongsViewController {
    func mySongs() {
        let nib = UINib(nibName: "MySongsCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "MySongsCell")
//        print(allSongs)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return purchases.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MySongsCell") as? MySongsCell else {
            fatalError()
        }
//        let songName = purchases.map { (song) -> String in
//            song.collectionName
//        }
//        for song in songName {
//            print("\(song)")
        let songPurchased = purchases[indexPath.row].collectionName
            cell.songs.text = songPurchased
        
        return cell
        }
    }



extension ViewController: CartDelegate {

    func emptyCartAction(row: Int) {
        self.cartArr = []
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "cart"), style: .plain, target: self, action: #selector(cartClicked))
    }
    
}
