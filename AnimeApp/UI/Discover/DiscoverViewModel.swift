//
//  DiscoverViewModel.swift
//  AnimeApp
//
//  Created by Camilo Orjuela on 10/02/22.
//  Copyright © 2022 Camilo Orjuela. All rights reserved.
//

import Foundation

class DiscoverViewModel {
    
    var topAnimes: [Anime] = []
    var selectedTopAnime: Anime?
    var seasonAnimes: [Anime] = []
    var service: AnimeServiceProtocol
    var database: AnimeDatabaseProtocol
    
    var onGetTopAnimes: (()->Void)?
    var onGetSeasonAnimes: (()->Void)?
    var loading: ((Bool)->Void)?
    
    private var isLoadingTopAnimes = false
    private var isLoadingSeasonAnimes = false
    
    init(service: AnimeServiceProtocol = AnimeService(), database: AnimeDatabaseProtocol = AnimeDatabase()) {
        self.service = service
        self.database = database
    }
    
    func getAnimes() {
        self.loading?(true)
        getTopAnime()
        getSeasonAnime()
    }
    
    func getTopAnime() {
        
        isLoadingTopAnimes = true
        
        service.getTopAnimes { [weak self] topAnime in
            
            self?.isLoadingTopAnimes = false
            
            if let isLoadingSeasonAnimes = self?.isLoadingSeasonAnimes, !isLoadingSeasonAnimes {
                self?.loading?(false)
            }
            
            if let topAnime = topAnime {
                self?.database.saveTopAnimes(topAnime)
            }
            
            self?.topAnimes = self?.database.getTopAnimes() ?? []
            
            self?.onGetTopAnimes?()
        }
    }
    
    func getSeasonAnime() {
        
        isLoadingSeasonAnimes = true
        
        service.getSeasonAnimes { [weak self] seasonAnime in
            
            self?.isLoadingSeasonAnimes = false
            
            if let isLoadingTopAnimes = self?.isLoadingTopAnimes, !isLoadingTopAnimes {
                self?.loading?(false)
            }
            
            if let seasonAnime = seasonAnime {
                self?.database.saveSeasonAnimes(seasonAnime)
            }
            
            self?.seasonAnimes = self?.database.getSeasonAnimes() ?? []
            self?.onGetSeasonAnimes?()
        }
    }
}
