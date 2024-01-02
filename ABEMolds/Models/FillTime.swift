//
//  FillTime.swift
//  ABEMolds
//
//  Created by Bruna Leal on 31/12/2023.
//

import Foundation

struct FillTime: Codable, Hashable {
    var max: Double
    var min: Double
    
    init(max: Double, min: Double) {
        self.max = max
        self.min = min
    }
}
