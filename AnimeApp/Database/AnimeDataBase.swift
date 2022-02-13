//
//  AnimeDataBase.swift
//  AnimeApp
//
//  Created by Camilo Orjuela on 10/02/22.
//  Copyright © 2022 Camilo Orjuela. All rights reserved.
//

import Foundation
import RealmSwift

protocol AnimeDatabaseProtocol {
    func saveTopAnimes(_ topAnimes: TopAnimesRemote)
    func getTopAnimes() -> [Anime]
    func getAnimeFromRemoteObject(_ anime: AnimeRemote) -> Anime
    func saveSeasonAnimes(_ seasonAnimes: SeasonAnimesRemote)
    func getSeasonAnimes() -> [Anime]
    func saveDetailAnime(_ detailAnime: AnimeDetailRemote)
    func getDetailAnime() -> AnimeDetail?
}

class AnimeDatabase: AnimeDatabaseProtocol {
    
    func saveTopAnimes(_ topAnimes: TopAnimesRemote) {
        
        //Borrar los datos actuales
        let realm = try! Realm()
        let allObjects = realm.objects(TopAnimes.self)
        
        try! realm.write {
            realm.delete(allObjects)
        }
        
        //Crear el objeto Realm
        let topAnimesRealm = TopAnimes()
        
        //Convertir animes del servicio en objetos realm
        for anime in topAnimes.top {
            topAnimesRealm.animes.append(getAnimeFromRemoteObject(anime))
        }
        
        try! realm.write {
            realm.add(topAnimesRealm)
        }
    }
    
    func getTopAnimes() -> [Anime] {
        
        let realm = try! Realm()
        
        if let topAnimes = realm.objects(TopAnimes.self).first?.animes {
            return Array(topAnimes)
        } else {
            return []
        }
    }
    
    func getAnimeFromRemoteObject(_ anime: AnimeRemote) -> Anime {
        let realmAnime = Anime()
        realmAnime.malID = anime.malID
        realmAnime.title = anime.title
        realmAnime.imageURL = anime.imageURL
        realmAnime.airingStart = anime.airingStart
        realmAnime.source = anime.source
        if let genresRemote = anime.genres {
            for genreRemote in genresRemote {
                let genre = Genre()
                genre.name = genreRemote.name
                realmAnime.genres.append(genre)
            }
        }
        
        return realmAnime
    }
    
    func saveSeasonAnimes(_ seasonAnimes: SeasonAnimesRemote) {
        
        //Borrar los datos actuales
        let realm = try! Realm()
        let allObjects = realm.objects(SeasonAnimes.self)
        
        try! realm.write {
            realm.delete(allObjects)
        }
        
        //Crear el objeto Realm
        let seasonAnimesRealm = SeasonAnimes()
        
        //Convertir animes del servicio en objetos realm
        for anime in seasonAnimes.anime {
            seasonAnimesRealm.seasons.append(getAnimeFromRemoteObject(anime))
        }
        
        try! realm.write {
            realm.add(seasonAnimesRealm)
        }
    }
    
    func getSeasonAnimes() -> [Anime] {
        
        let realm = try! Realm()
        
        if let seasonAnimes = realm.objects(SeasonAnimes.self).first?.seasons {
            return Array(seasonAnimes)
        } else {
            return []
        }
    }
    
    func saveDetailAnime(_ detailAnime: AnimeDetailRemote) {
        
        //Borrar los datos actuales
        let realm = try! Realm()
        let allObjects = realm.objects(AnimeDetail.self)
        
        try! realm.write {
            realm.delete(allObjects)
        }
        
        //Crear el objeto Realm
        let detailAnimesRealm = AnimeDetail()
        
        //Convertir animes del servicio en objetos realm
        detailAnimesRealm.malID = detailAnime.malID
        detailAnimesRealm.url = detailAnime.url
        detailAnimesRealm.imageURL = detailAnime.imageURL
        detailAnimesRealm.trailerURL = detailAnime.trailerURL
        detailAnimesRealm.title = detailAnime.title
        detailAnimesRealm.type = detailAnime.type
        detailAnimesRealm.episodes = detailAnime.episodes ?? 0
        detailAnimesRealm.status = detailAnime.status
        detailAnimesRealm.airing = detailAnime.airing ?? false
        detailAnimesRealm.duration = detailAnime.duration
        detailAnimesRealm.rating = detailAnime.rating
        detailAnimesRealm.score = detailAnime.score ?? 0
        detailAnimesRealm.scoredBy = detailAnime.scoredBy ?? 0
        detailAnimesRealm.synopsis = detailAnime.synopsis
        detailAnimesRealm.premiered = detailAnime.premiered
        if let genresRemote = detailAnime.genres {
            for genreRemote in genresRemote {
                let genre = Genre()
                genre.name = genreRemote.name
                detailAnimesRealm.genres.append(genre)
            }
        }
        
        try! realm.write {
            realm.add(detailAnimesRealm)
        }
    }
    
    func getDetailAnime() -> AnimeDetail? {
        
        let realm = try! Realm()
        
        return realm.objects(AnimeDetail.self).first
    }
}
