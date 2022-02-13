//
//  getAnime.swift
//  AnimeApp
//
//  Created by Camilo Orjuela on 9/02/22.
//  Copyright © 2022 Camilo Orjuela. All rights reserved.
//

import Foundation
import Alamofire

protocol AnimeServiceProtocol {
    func getTopAnimes(completion: @escaping (TopAnimesRemote?) -> Void)
    func getSeasonAnimes(completion: @escaping (SeasonAnimesRemote?) -> Void)
    func getDetailAnime(animeId: Int, completion: @escaping (AnimeDetailRemote?) -> Void)
}

class AnimeService: AnimeServiceProtocol {
    
    func getTopAnimes(completion: @escaping (TopAnimesRemote?) -> Void) {
        AF.request("https://api.jikan.moe/v3/top/anime/").responseDecodable(of: TopAnimesRemote.self) { response in
            
            guard let animesReceived = response.value else {
                completion (nil)
                return
            }
            
            completion(animesReceived)
        }
    
    }
    
    func getSeasonAnimes(completion: @escaping (SeasonAnimesRemote?) -> Void) {
        AF.request("https://api.jikan.moe/v3/season/later/").responseDecodable(of: SeasonAnimesRemote.self) { response in
            
            guard let animesReceived = response.value else {
                completion (nil)
                return
            }
            
            completion(animesReceived)
        }
    }
    
    func getDetailAnime(animeId: Int, completion: @escaping (AnimeDetailRemote?) -> Void) {
        
        AF.request("https://api.jikan.moe/v3/anime/\(animeId)").responseDecodable(of: AnimeDetailRemote.self) { response in
            
            guard let animesReceived = response.value else {
                completion (nil)
                return
            }
            
            completion (animesReceived)
        }
    }
}
