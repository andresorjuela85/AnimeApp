//
//  AnimeDetail.swift
//  AnimeApp
//
//  Created by Camilo Orjuela on 10/02/22.
//  Copyright © 2022 Camilo Orjuela. All rights reserved.
//

import Foundation
import RealmSwift

struct AnimeDetailRemote: Codable {
    let malID: Int
    let url: String?
    let imageURL: String?
    let trailerURL: String?
    let title: String?
    let type: String?
    let episodes: Int?
    let status: String?
    let airing: Bool?
    let duration: String?
    let rating: String?
    let score: Double?
    let scoredBy: Int?
    let synopsis: String?
    let premiered: String?
    let genres: [GenreRemote]?

    enum CodingKeys: String, CodingKey {
        case malID = "mal_id"
        case url
        case imageURL = "image_url"
        case trailerURL = "trailer_url"
        case title, type, episodes, status, airing, duration, rating, score
        case scoredBy = "scored_by"
        case synopsis, premiered, genres
    }
}

struct GenreRemote: Codable {
    let name: String
}

class AnimeDetail: Object {
   
    @objc dynamic var malID: Int = 0
    @objc dynamic var url: String?
    @objc dynamic var imageURL: String?
    @objc dynamic var trailerURL: String?
    @objc dynamic var title: String?
    @objc dynamic var type: String?
    @objc dynamic var episodes: Int = 0
    @objc dynamic var status: String?
    @objc dynamic var airing: Bool = false
    @objc dynamic var duration: String?
    @objc dynamic var rating: String?
    @objc dynamic var score: Double = 0
    @objc dynamic var scoredBy: Int = 0
    @objc dynamic var synopsis: String?
    @objc dynamic var premiered: String?
    let genres = List<Genre>()
}

class Genre: Object {
    @objc dynamic var name: String?
}
