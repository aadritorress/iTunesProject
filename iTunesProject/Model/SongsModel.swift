//
//  SongsModel.swift
//  iTunesProject
//
//  Created by Bryan Lee on 8/27/21.
//

import Foundation

struct Albums: Decodable {
    var results : [AlbumInfo]
}

struct AlbumInfo: Decodable {
    var collectionName: String
    var collectionPrice: Double
    var artworkUrl100: String
}
