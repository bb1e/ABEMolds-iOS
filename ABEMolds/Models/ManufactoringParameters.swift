//
//  ManufactoringParameters.swift
//  ABEMolds
//
//  Created by Bruna Leal on 29/12/2023.
//

import Foundation

struct ManufactoringParameters: Codable, Hashable {
    var cavityTemp: CavityTemp
    var coolingTemp: CoolingTemp
    var coolingTime: CoolingTime
    var fillPressure: FillPressure
    var fillTime: FillTime
    var holdPressure: HoldPressure
    var injectionFlow: InjectionFlow
    var packPressure: PackPressure
    var packTime: PackTime
    var plasticTemp: PlasticTemp
    
    init(cavityTemp: CavityTemp, coolingTemp: CoolingTemp, coolingTime: CoolingTime, fillPressure: FillPressure, fillTime: FillTime, holdPressure: HoldPressure, injectionFlow: InjectionFlow, packPressure: PackPressure, packTime: PackTime, plasticTemp: PlasticTemp) {
        self.cavityTemp = cavityTemp
        self.coolingTemp = coolingTemp
        self.coolingTime = coolingTime
        self.fillPressure = fillPressure
        self.fillTime = fillTime
        self.holdPressure = holdPressure
        self.injectionFlow = injectionFlow
        self.packPressure = packPressure
        self.packTime = packTime
        self.plasticTemp = plasticTemp
    }
}
