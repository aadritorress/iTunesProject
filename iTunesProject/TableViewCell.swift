//
//  TableViewCell.swift
//  iTunesProject
//
//  Created by Bryan Lee on 8/26/21.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var songTitle: UILabel!
    @IBOutlet weak var songPrice: UILabel!
    @IBOutlet weak var songImage: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
