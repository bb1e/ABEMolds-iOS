//
//  CavityTemp.swift
//  ABEMolds
//
//  Created by Bruna Leal on 29/12/2023.
//

import Foundation

struct CavityTemp: Codable, Hashable {
    var max: Double
    
    init(max: Double) {
        self.max = max
    }
}
