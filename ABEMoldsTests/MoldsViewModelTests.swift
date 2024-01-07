//
//  MoldsViewModelTests.swift
//  ABEMoldsTests
//
//  Created by Bruna Leal on 06/01/2024.
//

import XCTest
@testable import ABEMolds

class MoldsViewModelTests: XCTestCase {
   var viewModel: MoldsViewModel!
   var molds: [Mold]!

   override func setUp() {
       super.setUp()
       viewModel = MoldsViewModel()
       molds = [Mold(id: "1000", currentParameters: CurrentParameters(cavityTempC: 50, injectionFlow: 60, isAcceptingParts: true, isProducing: true, overrideUser: false, plasticTempC: 70, pressure: 36, stage: "Cooling"), dateManufactoringEnd: Date(), dateManufactoringStart: Date(), days: [Day(day: Date(), partsProduced: 28, partsRejected: 4), Day(day: Date(), partsProduced: 45, partsRejected: 3)], manufactoringParameters: ManufactoringParameters(cavityTemp: CavityTemp(max: 90), coolingTemp: CoolingTemp(max: 34, min: 10), coolingTime: CoolingTime(max: 45, min: 6), fillPressure: FillPressure(max: 7, min: 1), fillTime: FillTime(max: 34, min: 22), holdPressure: HoldPressure(max: 4, min: 1), injectionFlow: InjectionFlow(max: 7, min: 4), packPressure: PackPressure(max: 78, min: 12), packTime: PackTime(max: 22, min: 12), plasticTemp: PlasticTemp(max: 67, min: 11)), projectName: "project 1", customerName: "costumer 1", machineName: "machine 1", totalPartsProduced: 600, totalPartsRejected: 67, weeks: [Week(week: 40, year: 2023, partsProduced: 300), Week(week: 41, year: 2023, partsProduced: 300)]), Mold(id: "1001", currentParameters: CurrentParameters(cavityTempC: 50, injectionFlow: 60, isAcceptingParts: true, isProducing: true, overrideUser: false, plasticTempC: 70, pressure: 36, stage: "Cooling"), dateManufactoringEnd: Date(), dateManufactoringStart: Date(), days: [Day(day: Date(), partsProduced: 28, partsRejected: 4), Day(day: Date(), partsProduced: 45, partsRejected: 3)], manufactoringParameters: ManufactoringParameters(cavityTemp: CavityTemp(max: 90), coolingTemp: CoolingTemp(max: 34, min: 10), coolingTime: CoolingTime(max: 45, min: 6), fillPressure: FillPressure(max: 7, min: 1), fillTime: FillTime(max: 34, min: 22), holdPressure: HoldPressure(max: 4, min: 1), injectionFlow: InjectionFlow(max: 7, min: 4), packPressure: PackPressure(max: 78, min: 12), packTime: PackTime(max: 22, min: 12), plasticTemp: PlasticTemp(max: 67, min: 11)), projectName: "project 1", customerName: "costumer 1", machineName: "machine 1", totalPartsProduced: 600, totalPartsRejected: 67, weeks: [Week(week: 40, year: 2023, partsProduced: 300), Week(week: 41, year: 2023, partsProduced: 300)])]
   }

   override func tearDown() {
       viewModel = nil
       molds = nil
       super.tearDown()
   }

   func testPartsQualityChartData() {
       let chartData = viewModel.partsQualityChartData(molds: molds)
       
       XCTAssertEqual(chartData, [ChartData(name: "Working parts", value: 1066), ChartData(name: "Faulty parts", value: 134)])
   }
    
    func testPartsQualityByMold() {
        let chartData = viewModel.partsQualityByMoldChartData(mold: molds.first!)
        
        XCTAssertEqual(chartData, [ChartData(name: "Working parts", value: 600), ChartData(name: "Faulty parts", value: 67)])
    }
    
    func testPartsProducedWeekChartData() {
        let chartData = viewModel.partsProducedWeekChartData(molds: molds)
        
        XCTAssertEqual(chartData, [ChartData(name: "Week 40", value: 600), ChartData(name: "Week 41", value: 600)])
    }
    
    func testMoldsInProductionChartData() {
        let chartData = viewModel.moldsInProductionChartData(molds: molds)
        
        XCTAssertEqual(chartData, [ChartData(name: "In production", value: 0), ChartData(name: "Stopped", value: 2)])
    }
    
    func testIsAvailable() {
        let isAvailable = viewModel.isAvailable(mold: molds.first!)
        
        XCTAssertEqual(isAvailable, false)
    }
    
    func testAveragePartsProducedPerDay() {
        let average = viewModel.averagePartsProducedPerDay(mold: molds.first!)

        XCTAssertEqual(average, 36.5)
    }
    
    func testAveragePartsProducedPerWeek() {
        let average = viewModel.averagePartsProducedPerWeek(mold: molds.first!)
        
        XCTAssertEqual(average, 300.0)
    }
}

