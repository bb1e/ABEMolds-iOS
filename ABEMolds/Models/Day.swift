//
//  Days.swift
//  ABEMolds
//
//  Created by Bruna Leal on 29/12/2023.
//

import Foundation

struct Day: Codable, Hashable {
    var day: Date
    var partsProduced: Int
    var partsRejected: Int
    
    init(day: Date, partsProduced: Int, partsRejected: Int) {
        self.day = day
        self.partsProduced = partsProduced
        self.partsRejected = partsRejected
    }
}
