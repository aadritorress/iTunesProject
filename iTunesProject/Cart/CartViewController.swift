//
//  CartViewController.swift
//  iTunesProject
//
//  Created by Bryan Lee on 8/26/21.
//

import UIKit

class CartViewController: UITableViewController {
    
    var purchases: [AlbumInfo] = []
//    var mySongs: [AlbumInfo] = []
    var vcDelegate: CartDelegate?
    
    
    
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
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Buy", style: .plain, target: self, action: #selector(buyAction))
        
//        self.mySongs.append(contentsOf: purchases)
        _ = purchases.map { (song) -> String in
            song.collectionName
        }
//        print(songName)
    }
}

extension CartViewController {
    
    @objc func buyAction() {
        let cacheDirectory = FileManager.SearchPathDirectory.cachesDirectory
                let folderUrls = FileManager.default.urls(for: cacheDirectory, in: .userDomainMask)
                
                guard let fileURL = folderUrls.first?.appendingPathComponent("songs") else {
                    fatalError()
                }
        guard let oldData = FileManager.default.contents(atPath: fileURL.path) else {
            fatalError()
//            throw DiskStorageError.noData
        }
        var newArr : [AlbumInfo] = []
        
        do {
            let object = try JSONDecoder().decode([AlbumInfo].self, from: oldData)
            newArr = object
            newArr = newArr + self.purchases
            tableView.reloadData()
        } catch {
            fatalError()
        }

        guard let data = try? JSONEncoder().encode(newArr) else {
            fatalError()
        }
        do {
            try data.write(to: fileURL)
        } catch {
            fatalError()
        }
    
    self.purchases = []
    self.tableView.reloadData()
    vcDelegate?.emptyCartAction(row: 0)
    }
    
    
}


protocol CartDelegate {
    func emptyCartAction(row: Int)
    func deleteFromCart(row: Int)
}


extension CartViewController {
    func myPurchases() {
        let nib = UINib(nibName: "TitleViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "TitleViewCell")
        
        let nib2 = UINib(nibName: "NumberItemsCell", bundle: nil)
        tableView.register(nib2, forCellReuseIdentifier: "NumberItemsCell")
        }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let taken = UIContextualAction(style: .normal, title: "Delete") { (action, view, completion) in
                print("Just Swiped Taken", action)
                completion(true)
            //delete song from array
            let removedSong = self.purchases.remove(at: indexPath.row)
             self.tableView.reloadData()
            self.vcDelegate?.deleteFromCart(row: indexPath.row)
     //        print(purchases.remove(at: indexPath.row))
             print(removedSong)
           
            }
        taken.backgroundColor =  UIColor.red
        
        let config = UISwipeActionsConfiguration(actions: [taken])
                config.performsFirstActionWithFullSwipe = false
        return config
        }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return purchases.count + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.purchases.count == 0 {
            return UITableViewCell()
        } else if indexPath.row == purchases.count {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "NumberItemsCell") as? NumberItemsCell else {
                fatalError()
            }
            let totalSongs = purchases.count
            let songPrice = purchases.map { (song) -> Double in
                song.collectionPrice
            }
//            print(purchases)
//            print(songPrice)
//            print(songPrice.reduce(0, +))
            cell.numItems.text = "Num Items: \(String(totalSongs))"
            cell.totalPrice.text = "Price: \(songPrice.reduce(0, +))"
            return cell
            
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TitleViewCell", for: indexPath) as! TitleViewCell
            let selectedTitle = purchases[indexPath.row].collectionName
            let selectedPrice = purchases[indexPath.row].collectionPrice
//            print(selectedTitle, selectedPrice)
            cell.songTitle.text = selectedTitle
            cell.songPrice.text = String(selectedPrice)
            return cell
        }
    }
}

