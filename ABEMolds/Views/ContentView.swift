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
    @State var isalert = true
    
    init() {
        UITabBar.appearance().isHidden = true
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
                }
            }
        }
        .onChange(of: molds) { oldValue, newValue in
            Task {
                    self.totalPartsPerDayChartsData = viewModel.partsProducedChartData(molds: molds)
                    self.partsQualityChartData = viewModel.partsQualityChartData(molds: molds)
                    self.partsProducedPerWeekChartData = viewModel.partsProducedWeekChartData(molds: molds)
                    self.moldsInProductionChartData = viewModel.moldsInProductionChartData(molds: molds)
            }
        }
        /*.alert(isPresented: $isalert) {
            Alert(
                title: Text("Faulty part!"),
                message: Text("Do you want to proceed?"),
                primaryButton: .destructive(Text("Dismiss")) {
                    // Handle dismiss action here
                },
                secondaryButton: .default(Text("Take Me There")) {
                    // Handle "Take Me There" action here
                    
                }
            )
        }*/
        .onReceive(Timer.publish(every: 10, on: .main, in: .common).autoconnect()) { _ in
            Task {
                manager.observeChangesInMolds { result in
                    self.molds = result
                    /*manager.observeIsAcceptingParts(moldId: "1000") { result in
                     
                     }*/
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
