//
//  DashboardView.swift
//  ABEMolds
//
//  Created by Bruna Leal on 15/11/2023.
//

import SwiftUI

struct DashboardView: View {
    var manager = MoldsManager()
    @Binding var moldsInProdData: [ChartData]
    @Binding var partsProducedData: [ChartData]
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Welcome to your dashboard")
                    .font(.system(size: 35))
                    .bold()
                    .padding()
                    .padding(.trailing, 90)
                
                Spacer()
                VStack {
                    DonutChart(data: $moldsInProdData, title: "Molds in production",description: "Number of molds in production")
                        .frame(width: 200, height: 200)
                        .padding()
                        .padding(.top)
                }
                .padding(50)
                VStack {
                    BarChart(data: $partsProducedData, title: "Parts produced", description: "Number of parts produced per week")
                        .frame(height: 200)
                        .padding()
                        .padding(.bottom, 50)
                        .padding(.top)
                }
                .padding(50)
                Spacer()
            }
        }
        .padding(.top, 1)
    }
}

