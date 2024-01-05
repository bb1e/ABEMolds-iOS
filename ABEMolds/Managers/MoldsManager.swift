//
//  MoldsManager.swift
//  ABEMolds
//
//  Created by Bruna Leal on 29/12/2023.
//

import Foundation
import Firebase
import FirebaseFirestore

class MoldsManager: ObservableObject {
    //static let shared = MoldsManager()
    var db = Database.database().reference()
    
    @Published var molds = [Mold]()
    
    //init() {}
    
    func fetchMolds(completion: @escaping ([Mold]) -> Void) async {
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
                        
                        var days: [Day] = []
                        var weeks: [Week] = []
                        
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
                        let totalPartsRejected = moldData["totalPartsRejected"] as? Int ?? 0
                        
                        let finalManufacturingEndDate = dateFormatter.date(from: dateManufacturingEnd) ?? Date(timeIntervalSince1970: 0)
                        let finalManufacturingStartDate = dateFormatter.date(from: dateManufacturingStart) ?? Date()
                        
                        days = self.parseDays(moldSnapshot: moldSnapshot)
                        weeks = self.parseWeeks(moldSnapshot: moldSnapshot)
                                
                        let finalMold = Mold(id: moldId, currentParameters: CurrentParameters(cavityTempC: currentCavityTemp, injectionFlow: currentInjectionFlow, isAcceptingParts: currentIsAcceptingParts, isProducing: currentIsProducing, overrideUser: currentOverrideUser, plasticTempC: currentPlasticTemp, pressure: currentPressure, stage: currentStage), dateManufactoringEnd: finalManufacturingEndDate, dateManufactoringStart: finalManufacturingStartDate, days: days, manufactoringParameters: ManufactoringParameters(cavityTemp: CavityTemp(max: cavityTempMax), coolingTemp: CoolingTemp(max: coolingTempMax, min: coolingTempMin), coolingTime: CoolingTime(max: coolingTimeMax, min: coolingTimeMin), fillPressure: FillPressure(max: fillPressureMax, min: fillPressureMin), fillTime: FillTime(max: fillTimeMax, min: fillTimeMin), holdPressure: HoldPressure(max: holdPressureMax, min: holdPressureMin), injectionFlow: InjectionFlow(max: injectionFlowMax, min: injectionFlowMin), packPressure: PackPressure(max: packPressureMax, min: packPressureMin), packTime: PackTime(max: packTimeMax, min: packTimeMin), plasticTemp: PlasticTemp(max: plasticTempMax, min: plasticTempMin)), projectName: projectName, customerName: customerName, machineName: machineName, totalPartsProduced: totalPartsProduced, totalPartsRejected: totalPartsRejected, weeks: weeks)
                                //print("final mold: \(finalMold)")
                                molds.append(finalMold)
                                //print("completion: \(molds)")
                                completion(molds)
                    }
                }
                self.molds = molds
            })
            //completion(molds)
            //print("\n\n\n\n\n\nthis is all molds at the end of func: \(self.molds)")
        }
    }
    
    func updateOverrideUser(moldId: String, overrideUser: Bool) {
       let ref = Database.database().reference().child("molds").child(moldId)
       
       ref.updateChildValues(["currentParameters/overrideUser": overrideUser]) { error, _ in
           if let error = error {
               print("error overriding")
           } else {
               print("sucess overriding")
           }
       }
    }
    
    private func parseDays(moldSnapshot: DataSnapshot) -> [Day] {
       let dateFormatter = DateFormatter()
       dateFormatter.dateFormat = "MMddyyyy" // Ensure this matches the format of your dayId

       guard let daysSnapshot = moldSnapshot.childSnapshot(forPath: "days").children.allObjects as? [DataSnapshot] else {
           return []
       }

       return daysSnapshot.compactMap { daySnapshot -> Day? in
           let dayData = daySnapshot.value as? [String: Any]
           let dayId = daySnapshot.key
           //print(daySnapshot)
           let partsProduced = dayData?["partsProduced"] as? Int ?? 0
           //print(partsProduced)
           let partsRejected = dayData?["partsRejected"] as? Int ?? 0
           print(partsRejected)
           //print(dayId)
           if let day = dateFormatter.date(from: dayId) { // Ensure dayId can be converted to a Date
               return Day(day: day, partsProduced: partsProduced, partsRejected: partsRejected)
           } else {
               return nil
           }
       }
    }

        
    private func parseWeeks(moldSnapshot: DataSnapshot) -> [Week] {
        guard let weeksSnapshot = moldSnapshot.childSnapshot(forPath: "weeks").children.allObjects as? [DataSnapshot] else {
            return []
        }
        
        return weeksSnapshot.compactMap { weekSnapshot -> Week? in
            let weekData = weekSnapshot.value as? [String: Any]
            let weekId = weekSnapshot.key
            
            guard let partsProduced = weekData?["partsProduced"] as? Int else {
                return nil
            }
            
            let weekNumber = Int(weekId.dropLast(4)) ?? 0
            let year = Int(weekId.suffix(4)) ?? 0
            
            let week = Week(week: weekNumber, year: year, partsProduced: partsProduced)
            
            return week
        }
    }

    func observeChangesInMolds() -> Bool {
       let ref = Database.database().reference().child("molds")
        var change: Bool = false
        
       ref.observe(.childChanged, with: { snapshot in
           print("A child has changed: \(snapshot)")
           change = true
       })
        return change
    }
}
