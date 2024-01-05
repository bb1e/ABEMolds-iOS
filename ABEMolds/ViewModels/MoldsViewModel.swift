//
//  MoldsViewModel.swift
//  ABEMolds
//
//  Created by Bruna Leal on 29/12/2023.
//

import Foundation
import UserNotifications

class MoldsViewModel: ObservableObject {
    @Published var molds = [Mold]()
    var manager = MoldsManager()
    
    func partsQualityChartData(molds: [Mold]) -> [ChartData] {
        var data: [ChartData] = []
        var faulty: Int = 0
        var nonFaulty: Int = 0
        
        for mold in molds {
            nonFaulty += (mold.totalPartsProduced - mold.totalPartsRejected)
            faulty += mold.totalPartsRejected
        }
        
        data.append(ChartData(name: "Working parts", value: nonFaulty))
        data.append(ChartData(name: "Faulty parts", value: faulty))
        
        return data
    }
    
    func partsQualityByMoldChartData(mold: Mold) -> [ChartData] {
        var data: [ChartData] = []
        var faulty = mold.totalPartsRejected
        var nonFaulty = mold.totalPartsProduced
        
        data.append(ChartData(name: "Working parts", value: nonFaulty))
        data.append(ChartData(name: "Faulty parts", value: faulty))
        
        return data
    }
    
    
    func partsProducedChartData(molds: [Mold]) -> [ChartData] {
    var data: [ChartData] = []
      let uniqueDays = allUniqueDays(molds: molds)
      var dailyTotals: Int
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "dd-MM"

      for day in uniqueDays {
          dailyTotals = 0
          for mold in molds {
              for moldDay in mold.days {
                  let moldDayStr = dateFormatter.string(from: moldDay.day)
                  if day == moldDayStr {
                     dailyTotals += moldDay.partsProduced
                  }
              }
          }
          data.append(ChartData(name: day, value: dailyTotals))
      }
        
        let lastFiveDays = Array(data.suffix(5))

      return lastFiveDays
    }


    func allUniqueDays(molds: [Mold]) -> [String] {
        var uniqueDays: [String] = []
        var days: [Day] = []
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "dd-MM"

      for mold in molds {
          for day in mold.days {
              let dayStr = dateFormatter.string(from: day.day)
              if uniqueDays.contains(dayStr) {
                
              }
              else {
                  uniqueDays.append(dayStr)
              }
          }
      }
      return Array(uniqueDays)
    }

    
    func partsProducedByMoldChartData(mold: Mold) -> [ChartData]{
        var data: [ChartData] = []
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd"
        
        for day in mold.days {
            var daystr = dateFormatter.string(from: day.day)
            data.append(ChartData(name: daystr, value: day.partsProduced))
        }
        
        let lastFiveDays = Array(data.suffix(5))
        
        return lastFiveDays
    }
    
    func partsProducedWeekChartData(molds: [Mold]) -> [ChartData] {
       var weeklyTotals: [Int: Int] = [:]

       for mold in molds {
           for week in mold.weeks {
               let weekNumber = week.week
               let partsProducedInWeek = week.partsProduced

               if let existingTotal = weeklyTotals[weekNumber] {
                   weeklyTotals[weekNumber] = existingTotal + partsProducedInWeek
               } else {
                   weeklyTotals[weekNumber] = partsProducedInWeek
               }
           }
       }

       let sortedWeeklyTotals = weeklyTotals.sorted(by: <)

       let lastEightWeeks = Array(sortedWeeklyTotals.suffix(8))

       let chartData = lastEightWeeks.map { weekNumber, total in
           ChartData(name: "Week \(weekNumber)", value: total)
       }

       return chartData
    }



    
    func moldsInProductionChartData(molds: [Mold]) -> [ChartData] {
        var data: [ChartData] = []
        var on: Int = 0
        var off: Int = 0
        
        for mold in molds {
            if isAvailable(mold: mold) {
                on += 1
            }
            else {
                off += 1
            }
        }
        
        data.append(ChartData(name: "In production", value: on))
        data.append(ChartData(name: "Stopped", value: off))
        
        return data
    }
    
    
    func isAvailable(mold: Mold) -> Bool {
        var status: Bool = true
        let dateString = "1970-01-01T00:00:00+0000"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        let date = dateFormatter.date(from: dateString)
       
        if mold.dateManufactoringEnd != date {
            status = false
        }
        return status
    }
    
    func averagePartsProducedPerDay(mold: Mold) -> Double {
        var sum = 0
        
        for day in mold.days {
            sum += day.partsProduced
        }
        
        var average: Double = Double(sum) / Double(mold.days.count)
        
        return average
    }
    
    func averagePartsProducedPerWeek(mold: Mold) -> Double {
        var sum = 0
        
        for week in mold.weeks {
            sum += week.partsProduced
        }
        
        var average: Double = Double(sum) / Double(mold.weeks.count)
        
        return average
    }
    
    /*func checkIfAcceptingParts(molds: [Mold]) -> Bool {
        for mold in molds {
            manager.observeIsAcceptingParts(moldId: mold.id) { result in
                if result == true {
                    return
                }
            }
        }
    }*/
    
    
}
