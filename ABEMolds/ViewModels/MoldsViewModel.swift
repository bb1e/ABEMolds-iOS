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
    
    func getDataForContentViewCharts() {
        
    }
    
    func partsQualityChartData() {
        //quantity on faulty n non
    }
    
    func partsQualityByMoldChartData() {
        //quantity on faulty n non
    }
    
    func partsProducedChartData(){
        //parts produced per day
    }
    
    func partsProducedByMoldChartData(){
        //parts produced per day
    }
    
    func totalDownTimeChartData() {
        //downtime per day
    }
    
    func moldsInProductionChartData() {
        //current molds in production
    }
    
    //se a máquina está parada ou não
    func moldsInProduction() {
        var molds: [Mold] = []
        
        molds = self.getAllMolds()
        
    }
}
