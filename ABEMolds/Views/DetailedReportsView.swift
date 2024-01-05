//
//  DetailedReportsView.swift
//  ABEMolds
//
//  Created by Bruna Leal on 26/12/2023.
//

import SwiftUI

struct DetailedReportsView: View {
    @State var faultyPartsData: [ChartData] = []
    @State var partsProducedData: [ChartData] = []
    @State var dayAverage: Double = 0
    @State var weekAverage: Double = 0
    
    var viewModel = MoldsViewModel()
    
    @State var item: Mold
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ScrollView {
            VStack {
                Text(item.projectName)
                    .font(.system(size: 35))
                    .bold()
                    .padding()
                    .padding(.trailing)
                
                VStack {
                    DonutChart(data: $faultyPartsData, title: "Parts quality", description: "Number of parts with quality")
                        .frame(width: 200, height: 200)
                        .padding()
                }
                .padding(50)
                Spacer()
                VStack {
                    BarChart(data: $partsProducedData, title: "Parts produced", description: "Number of parts produced per day")
                        .frame(height: 200)
                        .padding()
                }
                .padding(50)
                Text("Parts produced (Total): \(item.totalPartsProduced)\nParts produced (avg/day): \(Int(dayAverage))\nParts produced (avg/week): \(Int(weekAverage))\n")
                .font(Font.custom("SF Pro", size: 20))
                .foregroundColor(.black)
                Spacer()
            }
        }
        .onAppear {
            Task {
                self.faultyPartsData = viewModel.partsQualityByMoldChartData(mold: item)
                self.partsProducedData = viewModel.partsProducedByMoldChartData(mold: item)
                self.dayAverage = viewModel.averagePartsProducedPerDay(mold: item)
                self.weekAverage = viewModel.averagePartsProducedPerWeek(mold: item)
            }
        }
    }
}
