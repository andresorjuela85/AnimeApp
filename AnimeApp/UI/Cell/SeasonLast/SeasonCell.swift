//
//  SeasonCell.swift
//  AnimeApp
//
//  Created by Camilo Orjuela on 10/02/22.
//  Copyright © 2022 Camilo Orjuela. All rights reserved.
//

import UIKit

class SeasonCell: UITableViewCell {
    
    @IBOutlet weak var animeImage: UIImageView! {
        didSet {
            animeImage.layer.cornerRadius = 10
        }
    }
    
    @IBOutlet weak var typeView: UIView! {
        didSet {
            typeView.layer.cornerRadius = 10
        }
    }
    @IBOutlet weak var typeLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var airingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func configure(anime: Anime) {
        
        if let imageUrl = anime.imageURL, let url = URL(string: imageUrl) {
            animeImage.af.setImage(withURL: url)
        }
        
        typeLabel.text = anime.source
        titleLabel.text = anime.title
        genreLabel.text = anime.genres.first?.name
        airingLabel.text = anime.airingStart?.toDate()?.toString()
    }
    
}

