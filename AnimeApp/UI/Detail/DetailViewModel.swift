//
//  DetailViewModel.swift
//  AnimeApp
//
//  Created by Camilo Orjuela on 11/02/22.
//  Copyright © 2022 Camilo Orjuela. All rights reserved.
//

import Foundation

class DetailViewModel {
    
    var detailAnime: AnimeDetail?
    var service: AnimeServiceProtocol
    var database: AnimeDatabaseProtocol
    var selectedID: Int
    
    var onGetDetailAnime: (()->Void)?
    var loading: ((Bool)->Void)?
    
    init(selectedID: Int, service: AnimeServiceProtocol = AnimeService(), database: AnimeDatabaseProtocol = AnimeDatabase()) {
        self.selectedID = selectedID
        self.service = service
        self.database = database
    }
    
    func getDetailAnime() {
        
        self.loading?(true)
        
        service.getDetailAnime(animeId: selectedID) { [weak self] detailAnime in
            
            self?.loading?(false)
            
            if let detailAnime = detailAnime {
                self?.database.saveDetailAnime(detailAnime)
            }
            
            self?.detailAnime = self?.database.getDetailAnime()
            self?.onGetDetailAnime?()
        }
    }
}

