//
//  String.swift
//  AnimeApp
//
//  Created by Camilo Orjuela on 12/02/22.
//  Copyright © 2022 Camilo Orjuela. All rights reserved.
//

import Foundation

extension String {
    
    func toDate() -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        return formatter.date(from: self)
    }
}
