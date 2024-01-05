//
//  DoughnutChart.swift
//  ABEMolds
//
//  Created by Bruna Leal on 14/11/2023.
//

import SwiftUI
import SwiftUICharts
import Charts

struct DonutChart: View {
    @Binding var data: [ChartData]
    var title: String
    var description: String

    var body: some View {
        VStack {
            Text(title)
                .font(.title3)
                .fontWeight(.semibold)
                .frame(alignment: .leading)
            VStack(alignment: .leading) {
                Text(description)
                 .font(.footnote)
                 .foregroundStyle(.gray)
                
                Chart(data, id: \.name) { macro in
                    SectorMark(
                        angle: .value("macros", macro.value),
                        innerRadius: .ratio(0.618),
                        angularInset: 1.5
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
