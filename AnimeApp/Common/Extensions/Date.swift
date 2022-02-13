//
//  Date.swift
//  AnimeApp
//
//  Created by Camilo Orjuela on 12/02/22.
//  Copyright © 2022 Camilo Orjuela. All rights reserved.
//

import Foundation

extension Date {
    
    func toString(format: String = "dd/MM/yyyy") -> String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
