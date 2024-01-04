//
//  ReportsView.swift
//  ABEMolds
//
//  Created by Bruna Leal on 14/11/2023.
//

import SwiftUI

struct ReportsView: View {
    @Binding var partsProducedData: [ChartData]
    @Binding var faultyPartsData: [ChartData]
    
    var body: some View {
        ScrollView {
            VStack {
                Text("General Reports")
                    .font(.system(size: 35))
                    .bold()
                    .padding()
                    .padding(.trailing, 90)
                
                Spacer()
                VStack {
                    BarChart(data: $partsProducedData, title: "Parts produced")
                        .frame(height: 200)
                        .padding()
                }
                .padding(50)
                Spacer()
                VStack {
                    PieChart(data: $faultyPartsData, title: "Parts quality")
                        .frame(width: 200, height: 200)
                        .padding()
                }
                .padding(50)
                Spacer()
            }
        }
    }
}


