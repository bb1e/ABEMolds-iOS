//
//  CurrentParameters.swift
//  ABEMolds
//
//  Created by Bruna Leal on 29/12/2023.
//

import Foundation

struct CurrentParameters: Codable {
    var cavityTempC: Double
    var injectionFlow: Double
    var isAcceptingParts: Bool
    var isProducing: Bool
    var overrideUser: Bool
    var plasticTempC: Double
    var pressure: Double
    var stage: String
}
