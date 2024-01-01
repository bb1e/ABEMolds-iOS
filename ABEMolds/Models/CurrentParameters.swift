//
//  CurrentParameters.swift
//  ABEMolds
//
//  Created by Bruna Leal on 29/12/2023.
//

import Foundation

struct CurrentParameters: Codable, Hashable {
    
    var cavityTempC: Double
    var injectionFlow: Double
    var isAcceptingParts: Bool
    var isProducing: Bool
    var overrideUser: Bool
    var plasticTempC: Double
    var pressure: Double
    var stage: String
    
    init(cavityTempC: Double, injectionFlow: Double, isAcceptingParts: Bool, isProducing: Bool, overrideUser: Bool, plasticTempC: Double, pressure: Double, stage: String) {
        self.cavityTempC = cavityTempC
        self.injectionFlow = injectionFlow
        self.isAcceptingParts = isAcceptingParts
        self.isProducing = isProducing
        self.overrideUser = overrideUser
        self.plasticTempC = plasticTempC
        self.pressure = pressure
        self.stage = stage
    }
}
