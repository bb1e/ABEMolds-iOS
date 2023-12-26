//
//  ReportsView.swift
//  ABEMolds
//
//  Created by Bruna Leal on 14/11/2023.
//

import SwiftUI

struct ReportsView: View {
    let doughnutData: [Double] = [75, 25]
    let lineChartData: [Double] = [10, 25, 67, 30, 20, 40, 35]
    let colors: [Color] = [Color.mint, Color.orange]
    
    var body: some View {
        ScrollView {
            VStack {
                Text("General Reports")
                    .font(.system(size: 35))
                    .bold()
                    .padding()
                    .padding(.trailing, 90)
                
                Spacer()
                //homepage stats
                LineChart(data: lineChartData, title: "Parts Produced")
                    .frame(height: 200)
                    .padding()
                    .padding(.bottom, 130)
                Spacer()
                DonutChart(dataPoints: doughnutData, colors: colors)
                 .frame(width: 200, height: 200)
                 .padding()
                 Spacer()
            }
        }
    }
}

#Preview {
    ReportsView()
}
