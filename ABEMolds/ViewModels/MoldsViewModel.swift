//
//  MoldsViewModel.swift
//  ABEMolds
//
//  Created by Bruna Leal on 29/12/2023.
//

import Foundation

class MoldsViewModel: ObservableObject {
    @Published var molds = [Mold]()
    var manager = MoldsManager()
    
    func getAllMolds() -> [Mold] {
        var molds: [Mold] = []
        
        manager.fetchMolds { fetchedMolds in
            self.molds = fetchedMolds
            //print(fetchedMolds)
        }
        
        return molds
    }
    
    //tentar fazer o return dos ultimos 10
    
    func partsQualityChartData(molds: [Mold]) -> [ChartData] {
        //quantity on faulty n non
        var data: [ChartData] = []
        var faulty: Int = 0
        var nonFaulty: Int = 0
        
        for mold in molds {
            //data.append(ChartData(name: <#T##String#>, value: <#T##Int#>))
        }
        
        return data
    }
    
    func partsQualityByMoldChartData(molds: [Mold]) -> [ChartData] {
        //quantity on faulty n non
        var data: [ChartData] = []
        var faulty: Int = 0
        var nonFaulty: Int = 0
        
        return data
    }
    
    func partsProducedChartData(molds: [Mold]) -> [ChartData]{
        //parts produced per day
        var data: [ChartData] = []
        
        for mold in molds {
            //data.append(ChartData(name: <#T##String#>, value: <#T##Int#>))
        }
        
        return data
    }
    
    func partsProducedByMoldChartData(mold: Mold) -> [ChartData]{
        //parts produced per day
        var data: [ChartData] = []
        
        let dateFormatter = DateFormatter()
        
        for day in mold.days {
            var daystr = dateFormatter.string(from: day.day)
            data.append(ChartData(name: daystr, value: day.partsProduced))
        }
        print(data)
        
        return data
    }
    
    func totalDownTimeChartData(molds: [Mold]) -> [ChartData] {
        //downtime per day
        var data: [ChartData] = []
        
        return data
    }
    
    func moldsInProductionChartData(molds: [Mold]) -> [ChartData] {
        //current molds in production
        var data: [ChartData] = []
        
        return data
    }
    
    //se a máquina está parada ou não
    func moldsInProduction() {
        var molds: [Mold] = []
        
        molds = self.getAllMolds()
        
    }
}
