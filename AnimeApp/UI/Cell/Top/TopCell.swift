//
//  TopCell.swift
//  AnimeApp
//
//  Created by Camilo Orjuela on 10/02/22.
//  Copyright © 2022 Camilo Orjuela. All rights reserved.
//

import UIKit
import WebKit
import AlamofireImage

class TopCell: UICollectionViewCell {
    
    @IBOutlet weak var topImage: UIImageView! {
        didSet {
            topImage.layer.cornerRadius = 16
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        
    }
    
    func configure(anime: Anime) {
        let url = URL(string: anime.imageURL!)!
        topImage.af.setImage(withURL: url)
    }
    
   

}
