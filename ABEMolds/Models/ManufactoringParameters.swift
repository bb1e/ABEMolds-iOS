//
//  ManufactoringParameters.swift
//  ABEMolds
//
//  Created by Bruna Leal on 29/12/2023.
//

import Foundation

struct ManufactoringParameters: Codable {
    var cavityTemp: CavityTemp
    var coolingTemp: CoolingTemp
    var coolingTime: CoolingTime
    var fillPressure: FillPressure
    var holdPressure: HoldPressure
    var injectionFlow: InjectionFlow
    var packPressure: PackPressure
    var packTime: PackTime
    var plasticTemp: PlasticTemp
}
