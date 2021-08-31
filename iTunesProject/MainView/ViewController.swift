//
//  ViewController.swift
//  iTunesProject
//
//  Created by Adri Torres on 8/26/21.
//

import UIKit

class ViewController: UITableViewController {
    
    var albumsArr : [AlbumInfo] = []
    var cartArr : [AlbumInfo] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Browse"
        configureTableView()
        configItunes()
        fetchData()
    }
    
    private func fetchData() {
        let songsStr = "https://itunes.apple.com/search?term=taylor&entity=album"
        if let url = URL(string: songsStr){
            URLSession.shared.dataTask(with: url, completionHandler: {(data, response, error) in
                let decoder = JSONDecoder()
                if let data = data {
                    do {
                        let albums = try decoder.decode(Albums.self, from: data)
                        self.albumsArr = albums.results
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    } catch {
                        print(error)
                    }
                }
            }).resume()
        } else {
            fatalError()
        }
        
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

extension ViewController: CartDelegate {
    func deleteFromCart(row: Int) {
        self.cartArr.remove(at: row)
        if cartArr.count == 0 {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "cart"), style: .done, target: self, action: #selector(cartClicked)) }
    }
    
    func emptyCartAction(row: Int) {
        self.cartArr = []
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "cart"), style: .plain, target: self, action: #selector(cartClicked))
    }
}

extension ViewController {
    func configureTableView() {
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "TableViewCell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.albumsArr.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as? TableViewCell else {
            fatalError()
        }
        let imageStr = albumsArr[indexPath.row].artworkUrl100
        cell.songTitle.text = albumsArr[indexPath.row].collectionName
        cell.songPrice.text = String(albumsArr[indexPath.row].collectionPrice)
        fetchImage(imageStr: imageStr, completion: { image in
            cell.songImage.image = image
        })
        
        return cell
    }
    
    func fetchImage(imageStr: String, completion: @escaping (UIImage?) -> Void) {
        if let image = ImageCache.shared.read(imageStr: imageStr) {
            completion(image)
        } else {
            if let imageURL = URL(string: imageStr) {
                URLSession.shared.dataTask(with: imageURL) { data, r, e in
                    guard let data = data else { return }
                    DispatchQueue.main.async {
                        if let image = UIImage(data: data) {
                            ImageCache.shared.write(imageStr: imageStr, image: image)
                            completion(image)
                        }
                    }
                }.resume()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let sendButton = UIAlertAction(title: "Add to cart", style: .default, handler: { (action) -> Void in
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "cart.fill"), style: .plain, target: self, action: #selector(self.cartClicked))
            
            self.cartArr.append(self.albumsArr[indexPath.row])
           })
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) -> Void in
               print("Cancel button tapped")
           })
        
        alert.addAction(sendButton)
        alert.addAction(cancelButton)
        
        self.navigationController!.present(alert, animated: true, completion: nil)
    }
    
    
    @objc func cartClicked() {
        let storyboard = UIStoryboard(name: "CartViewStoryboard", bundle: nil)
        
        guard let cartVC = storyboard.instantiateInitialViewController() as? CartViewController else {
            assertionFailure("Could not instantiate CartViewController")
            return
        }
        
        cartVC.purchases = self.cartArr
        cartVC.vcDelegate = self
        
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

extension ViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            let albumStr = albumsArr[indexPath.row].artworkUrl100
            fetchImage(imageStr: albumStr, completion: { _ in })
        }
    }
}
