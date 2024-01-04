//
//  LineChart.swift
//  ABEMolds
//
//  Created by Bruna Leal on 14/11/2023.
//

import SwiftUI
import SwiftUICharts
import Charts

struct BarChart: View {
    @Binding var data: [ChartData]
    var title: String

    var body: some View {
        VStack {
            Text(title)
                .font(.title3)
                .fontWeight(.semibold)
                .frame(alignment: .leading)
            VStack(alignment: .leading) {
                /*Text("")
                 .font(.footnote)
                 .foregroundStyle(.gray)*/
                
                Chart(data, id: \.name) { macro in
                    BarMark(
                        x: .value("Day", macro.name),
                        y: .value("Parts Produced", macro.value)
                    )
                    .cornerRadius(4)
                    .foregroundStyle(by: .value("Name", macro.name))
                }
                .frame(height: 250)
                .chartXAxis(.hidden)
            }
        }
    }
}


