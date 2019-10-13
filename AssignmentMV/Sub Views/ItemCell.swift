//
//  ItemCell.swift
//  AssignmentMV
//
//  Created by Mahendra Vishwakarma on 13/10/19.
//  Copyright © 2019 Mahendra Vishwakarma. All rights reserved.
//

import UIKit

class ItemCell: UICollectionViewCell {
    
    @IBOutlet weak var cellImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        cellImage.layer.cornerRadius = 4
        cellImage.layer.masksToBounds = true
        
    }
    
    func setupData(post:Photo) {
       
        cellImage.image = nil
        let url = String(format: URLs.image, post.farm,post.server,post.id,post.secret)
        cellImage.downloadImage(withUrl: url)
    }

}
