//
//  PieChart.swift
//  ABEMolds
//
//  Created by Bruna Leal on 02/01/2024.
//

import SwiftUI
import SwiftUICharts
import Charts

struct PieChart: View {
    @Binding var data: [ChartData]
    var title: String

    var body: some View {
        VStack {
            Text(title)
                .font(.title3)
                .fontWeight(.semibold)
                .frame(alignment: .leading)
            VStack(alignment: .leading) {
                Chart(data, id: \.name) { macro in
                    SectorMark(
                        angle: .value("macros", macro.value),
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


