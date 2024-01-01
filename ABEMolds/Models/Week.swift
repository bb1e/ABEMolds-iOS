//
//  Weeks.swift
//  ABEMolds
//
//  Created by Bruna Leal on 29/12/2023.
//

import Foundation

struct Week: Codable, Hashable {
    var week: Int
    var year: Int
    var partsProduced: Int
    
    init(week: Int, year: Int, partsProduced: Int) {
        self.week = week
        self.year = year
        self.partsProduced = partsProduced
    }
}
