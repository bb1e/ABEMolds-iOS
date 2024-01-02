//
//  MoldsManager.swift
//  ABEMolds
//
//  Created by Bruna Leal on 29/12/2023.
//

import Foundation
import Firebase
import FirebaseFirestore

class MoldsManager {
    static let shared = MoldsManager()
    private var db = Firestore.firestore()
    
    init() {}
    
    func fetchMolds(completion: @escaping ([Mold]) -> Void) {
        Task {
            let ref = Database.database().reference().child("molds")
            var molds: [Mold] = []
            let dispatchGroup = DispatchGroup()
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM-dd-yyyy hh:mm"
            
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                guard let moldsSnapshot = snapshot.children.allObjects as? [DataSnapshot] else {
                    print("não tem molds")
                    return
                }
                
                for moldSnapshot in moldsSnapshot {
                    //print("achei molds")
                    //print(moldSnapshot)
                    
                    if let moldData = moldSnapshot.value as? [String: Any] {
                        var currentCavityTemp: Double = 0.0
                        var currentInjectionFlow: Double = 0.0
                        var currentIsAcceptingParts: Bool = true
                        var currentIsProducing: Bool = true
                        var currentOverrideUser: Bool = false
                        var currentPlasticTemp: Double = 0.0
                        var currentPressure: Double = 0.0
                        var currentStage: String = ""
                        var cavityTempMax: Double = 0.0
                        var coolingTempMax: Double = 0.0
                        var coolingTempMin: Double = 0.0
                        var coolingTimeMax: Double = 0.0
                        var coolingTimeMin: Double = 0.0
                        var fillPressureMax: Double  = 0.0
                        var fillPressureMin: Double = 0.0
                        var fillTimeMax: Double = 0.0
                        var fillTimeMin: Double = 0.0
                        var holdPressureMax: Double = 0.0
                        var holdPressureMin: Double = 0.0
                        var injectionFlowMax: Double = 0.0
                        var injectionFlowMin: Double = 0.0
                        var packPressureMax: Double = 0.0
                        var packPressureMin: Double = 0.0
                        var packTimeMax: Double = 0.0
                        var packTimeMin: Double = 0.0
                        var plasticTempMax: Double = 0.0
                        var plasticTempMin: Double = 0.0
                        
                        let moldId = moldSnapshot.key

                        if let currentParameters = moldData["currentParameters"] as? [String: Any]{
                            currentCavityTemp = currentParameters["cavityTempC"] as? Double ?? 0.0
                            currentInjectionFlow = currentParameters["injectionFlow"] as? Double ?? 0.0
                            currentIsAcceptingParts = currentParameters["isAcceptingParts"] as? Bool ?? true
                            currentIsProducing = currentParameters["isProducing"] as? Bool ?? true
                            currentOverrideUser = currentParameters["overrideUser"] as? Bool ?? false
                            currentPlasticTemp = currentParameters["plasticTempC"] as? Double ?? 0.0
                            currentPressure = currentParameters["pressure"] as? Double ?? 0.0
                            currentStage = currentParameters["stage"] as? String ?? ""
                        }
                        
                        let dateManufacturingEnd = moldData["dateManufacturingEnd"] as? String ?? ""
                        let dateManufacturingStart = moldData["dateManufacturingStart"] as? String ?? ""
                        let customerName = moldData["customerName"] as? String ?? ""
                        let machineName = moldData["machineName"] as? String ?? ""
                        
                        if let manufacturingParameters = moldData["manufacturingParameters"] as? [String: Any]{
                            //print("manufacturing parameters: \(manufacturingParameters)")
                            if let cavityTemp = manufacturingParameters["cavityTemp"] as? [String: Any] {
                                cavityTempMax = cavityTemp["max"] as? Double ?? 0.0
                            }
                            if let coolingTemp = manufacturingParameters["coolingTemp"] as? [String: Any] {
                                coolingTempMax = coolingTemp["max"] as? Double ?? 0.0
                                coolingTempMin = coolingTemp["min"] as? Double ?? 0.0
                            }
                            if let coolingTime = manufacturingParameters["coolingTime"] as? [String: Any] {
                                coolingTimeMax = coolingTime["max"] as? Double ?? 0.0
                                coolingTimeMin = coolingTime["min"] as? Double ?? 0.0
                            }
                            if let fillPressure = manufacturingParameters["fillPressure"] as? [String: Any] {
                                fillPressureMax = fillPressure["max"] as? Double ?? 0.0
                                fillPressureMin = fillPressure["min"] as? Double ?? 0.0
                            }
                            if let fillTime = manufacturingParameters["fillTime"] as? [String: Any] {
                                fillTimeMax = fillTime["max"] as? Double ?? 0.0
                                fillTimeMin = fillTime["min"] as? Double ?? 0.0
                            }
                            if let holdPressure = manufacturingParameters["holdPressure"] as? [String: Any] {
                                holdPressureMax = holdPressure["max"] as? Double ?? 0.0
                                holdPressureMin = holdPressure["min"] as? Double ?? 0.0
                            }
                            if let injectionFlow = manufacturingParameters["injectionFlow"] as? [String: Any] {
                                injectionFlowMax = injectionFlow["max"] as? Double ?? 0.0
                                injectionFlowMin = injectionFlow["min"] as? Double ?? 0.0
                            }
                            if let packPressure = manufacturingParameters["packPressure"] as? [String: Any] {
                                packPressureMax = packPressure["max"] as? Double ?? 0.0
                                packPressureMin = packPressure["min"] as? Double ?? 0.0
                            }
                            if let packTime = manufacturingParameters["packTime"] as? [String: Any] {
                                packTimeMax = packTime["max"] as? Double ?? 0.0
                                packTimeMin = packTime["min"] as? Double ?? 0.0
                            }
                            if let plasticTemp = manufacturingParameters["plasticTemp"] as? [String: Any] {
                                plasticTempMax = plasticTemp["max"] as? Double ?? 0.0
                                plasticTempMin = plasticTemp["min"] as? Double ?? 0.0
                            }
                        }
                        let projectName = moldData["projectName"] as? String ?? ""
                        let totalPartsProduced = moldData["totalPartsProduced"] as? Int ?? 0
                        
                        let finalManufacturingEndDate = dateFormatter.date(from: dateManufacturingEnd) ?? Date(timeIntervalSince1970: 0)
                        let finalManufacturingStartDate = dateFormatter.date(from: dateManufacturingStart) ?? Date()
                        
                        dispatchGroup.enter()
                        self.fetchDaysForMold(moldId: moldId) { days in
                            self.fetchWeeksForMold(moldId: moldId) { weeks in
                                
                                let finalMold = Mold(id: moldId, currentParameters: CurrentParameters(cavityTempC: currentCavityTemp, injectionFlow: currentInjectionFlow, isAcceptingParts: currentIsAcceptingParts, isProducing: currentIsProducing, overrideUser: currentOverrideUser, plasticTempC: currentPlasticTemp, pressure: currentPressure, stage: currentStage), dateManufactoringEnd: finalManufacturingEndDate, dateManufactoringStart: finalManufacturingStartDate, days: days, manufactoringParameters: ManufactoringParameters(cavityTemp: CavityTemp(max: cavityTempMax), coolingTemp: CoolingTemp(max: coolingTempMax, min: coolingTempMin), coolingTime: CoolingTime(max: coolingTimeMax, min: coolingTimeMin), fillPressure: FillPressure(max: fillPressureMax, min: fillPressureMin), fillTime: FillTime(max: fillTimeMax, min: fillTimeMin), holdPressure: HoldPressure(max: holdPressureMax, min: holdPressureMin), injectionFlow: InjectionFlow(max: injectionFlowMax, min: injectionFlowMin), packPressure: PackPressure(max: packPressureMax, min: packPressureMin), packTime: PackTime(max: packTimeMax, min: packTimeMin), plasticTemp: PlasticTemp(max: plasticTempMax, min: plasticTempMin)), projectName: projectName, customerName: customerName, machineName: machineName, totalPartsProduced: totalPartsProduced, weeks: weeks)
                                //print("final mold: \(finalMold)")
                                molds.append(finalMold)
                                dispatchGroup.leave()
                                print("completion: \(molds)")
                                completion(molds)
                                //print("molds after append: \(molds)")
                            }
                        }
                    }
                }
            })
            dispatchGroup.notify(queue: .main) {
                //print(molds)
                completion(molds)
            }
        }
    }
    
    func fetchDaysForMold(moldId: String, completion: @escaping ([Day]) -> Void) {
        let ref = Database.database().reference().child("molds").child("\(moldId)").child("days")
        var days: [Day] = []
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMddyyyy"

        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let daysSnapshot = snapshot.children.allObjects as? [DataSnapshot] else {
                print("No days found")
                return
            }

            for daySnapshot in daysSnapshot {
                if let dayData = daySnapshot.value as? [String: Any] {
                    let dayId = daySnapshot.key
                    let partsProduced = dayData["partsProduced"] as? Int ?? 0
                    
                    if let date = dateFormatter.date(from: dayId) {
                        let day = Day(day: date, partsProduced: partsProduced)
                        days.append(day)
                    }
                }
            }
            completion(days)
        })
    }
    
    func fetchWeeksForMold(moldId: String, completion: @escaping ([Week]) -> Void) {
        let ref = Database.database().reference().child("molds").child("\(moldId)").child("weeks")
        var weeks: [Week] = []

        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let weeksSnapshot = snapshot.children.allObjects as? [DataSnapshot] else {
                print("No weeks found")
                return
            }

            for weekSnapshot in weeksSnapshot {
                if let weekData = weekSnapshot.value as? [String: Any] {
                    let weekId = weekSnapshot.key
                    let partsProduced = weekData["partsProduced"] as? Int ?? 0
                    
                    let weekNumber = Int(weekId.dropLast(4)) ?? 0
                    let year = Int(weekId.suffix(4)) ?? 0
                    //print("this is week \(weekNumber) and year \(year)")
                    
                    let week = Week(week: weekNumber, year: year, partsProduced: partsProduced)
                    weeks.append(week)
                }
            }
            completion(weeks)
        })
    }
    
    func updateOverrideUser(moldId: String, overrideUser: Bool, completion: @escaping (Result<Void, Error>) -> Void) {
       let ref = Database.database().reference().child("molds").child(moldId)
       
       ref.updateChildValues(["currentParameters/overrideUser": overrideUser]) { error, _ in
           if let error = error {
               completion(.failure(error))
           } else {
               completion(.success(()))
           }
       }
    }
}
