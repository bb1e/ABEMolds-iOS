//
//  ContentView.swift
//  ABEMolds
//
//  Created by Bruna Leal on 08/11/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab: Tab = .house
    var viewModel = MoldsViewModel()
    var manager = MoldsManager()
    @State var molds: [Mold] = []
    @State var totalPartsPerDayChartsData: [ChartData] = []
    @State var partsQualityChartData: [ChartData] = []
    @State var partsProducedPerWeekChartData: [ChartData] = []
    @State var moldsInProductionChartData: [ChartData] = []
    @State var changed: Bool = false
    
    init() {
        UITabBar.appearance().isHidden = true
        changed = manager.observeChangesInMolds()

    }
    
    
    var body: some View {
        ZStack {
            VStack {
                Group {
                    if selectedTab == .leaf {
                        ReportsView(partsProducedData:  $totalPartsPerDayChartsData, faultyPartsData: $partsQualityChartData)
                    } else if selectedTab == .house {
                        DashboardView(moldsInProdData: $moldsInProductionChartData, partsProducedData: $partsProducedPerWeekChartData)
                    } else if selectedTab == .gearshape {
                        MoldsView(molds: $molds)
                    }
                }
                VStack {
                    //Spacer()
                    CustomTabBar(selectedTab: $selectedTab)
                }
            }
        }
        .onAppear {
            Task {
                await manager.fetchMolds { fetchedMolds in
                    self.molds = fetchedMolds
                    self.totalPartsPerDayChartsData = viewModel.partsProducedChartData(molds: molds)
                    self.partsQualityChartData = viewModel.partsQualityChartData(molds: molds)
                    self.partsProducedPerWeekChartData = viewModel.partsProducedWeekChartData(molds: molds)
                    self.moldsInProductionChartData = viewModel.moldsInProductionChartData(molds: molds)
                    //print(molds.count)
                    //print(totalPartsPerDayChartsData)
                    //print(partsQualityChartData)
                    //print(partsProducedPerWeekChartData)
                    //print(moldsInProductionChartData)
                }
            }
            viewModel.scheduleNotification(title: "notificação", body: "this is a notif")
        }
        .onChange(of: changed) { oldValue, newValue in
            Task {
                await manager.fetchMolds { fetchedMolds in
                    self.molds = fetchedMolds
                    self.totalPartsPerDayChartsData = viewModel.partsProducedChartData(molds: molds)
                    self.partsQualityChartData = viewModel.partsQualityChartData(molds: molds)
                    self.partsProducedPerWeekChartData = viewModel.partsProducedWeekChartData(molds: molds)
                    self.moldsInProductionChartData = viewModel.moldsInProductionChartData(molds: molds)
                    print(molds.first?.currentParameters.overrideUser)
                    //print(molds.count)
                    //print(totalPartsPerDayChartsData)
                    //print(partsQualityChartData)
                    //print(partsProducedPerWeekChartData)
                    //print(moldsInProductionChartData)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
