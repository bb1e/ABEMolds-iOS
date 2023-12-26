//
//  DashboardView.swift
//  ABEMolds
//
//  Created by Bruna Leal on 15/11/2023.
//

import SwiftUI

struct DashboardView: View {
    let doughnutData: [Double] = [30, 70]
    let lineChartData: [Double] = [10, 25, 15, 30, 20, 40, 35]
    let colors: [Color] = [Color.green, Color.yellow]
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Welcome to your dashboard")
                    .font(.system(size: 35))
                    .bold()
                    .padding()
                    .padding(.trailing, 90)
                
                Spacer()
                //homepage stats
                DonutChart(dataPoints: doughnutData, colors: colors)
                 .frame(width: 200, height: 200)
                 .padding()
                 Spacer()
                LineChart(data: lineChartData, title: "Line Chart")
                    .frame(height: 200)
                    .padding()
                    .padding(.bottom, 200)
                Spacer()
            }
        }
    }
}

#Preview {
    DashboardView()
}