//
//  InjectionFlow.swift
//  ABEMolds
//
//  Created by Bruna Leal on 29/12/2023.
//

import Foundation

struct InjectionFlow: Codable, Hashable {
    var max: Double
    var min: Double
    
    init(max: Double, min: Double) {
        self.max = max
        self.min = min
    }
}
