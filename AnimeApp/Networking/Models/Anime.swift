//
//  Anime.swift
//  AnimeApp
//
//  Created by Camilo Orjuela on 9/02/22.
//  Copyright © 2022 Camilo Orjuela. All rights reserved.
//

import Foundation
import RealmSwift

struct TopAnimesRemote: Codable {
    let top: [AnimeRemote]
}

struct SeasonAnimesRemote: Codable {
    let anime: [AnimeRemote]
}

struct AnimeRemote: Codable {
    let malID: Int
    let title: String?
    let imageURL: String?
    let airingStart: String?
    let source: String?
    let genres: [GenreRemote]?

    enum CodingKeys: String, CodingKey {
        case malID = "mal_id"
        case title
        case imageURL = "image_url"
        case airingStart = "airing_start"
        case source
        case genres
    }
}

class TopAnimes: Object {
    let animes = List<Anime>()
}

class SeasonAnimes: Object {
    let seasons = List<Anime>()
}

class Anime: Object {
    @objc dynamic var malID: Int = 0
    @objc dynamic var title: String?
    @objc dynamic var imageURL: String?
    @objc dynamic var airingStart: String?
    @objc dynamic var source: String?
    let genres = List<Genre>()
}

