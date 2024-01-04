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
    
    var viewModel = MoldsViewModel()
    
    var item: Mold
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
                    DonutChart(data: $faultyPartsData, title: "Parts quality")
                        .frame(width: 200, height: 200)
                        .padding()
                }
                .padding(50)
                Spacer()
                VStack {
                    BarChart(data: $partsProducedData, title: "Parts produced")
                        .frame(height: 200)
                        .padding()
                }
                .padding(50)
                Text("Parts produced (Total): 15 000\nParts produced (avg/day): 15 000\nParts produced (avg/week): 15 000\n")
                .font(Font.custom("SF Pro", size: 20))
                .foregroundColor(.black)
                Spacer()
            }
        }
        .onAppear {
            Task {
                self.faultyPartsData = viewModel.partsQualityByMoldChartData(mold: item)
                self.partsProducedData = viewModel.partsProducedByMoldChartData(mold: item)
            }
        }
    }
}
