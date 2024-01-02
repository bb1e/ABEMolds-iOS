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
    @State private var data: [ChartData] = [
        .init(name: "mold 1", value: 100),
        .init(name: "mold 2", value: 250),
        .init(name: "mold 3", value: 50)
    ]

    var body: some View {
        VStack(alignment: .leading) {
            Text("Parts Quality")
                .font(.title2)
                .fontWeight(.semibold)
            
            /*Text("")
                .font(.footnote)
                .foregroundStyle(.gray)*/
            
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
        .padding()
    }
}
