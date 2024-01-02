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

    @State private var data: [ChartData] = [
        .init(name: "mold 1", value: 100),
        .init(name: "mold 2", value: 250),
        .init(name: "mold 3", value: 50)
    ]

    var body: some View {
        VStack(alignment: .leading) {
            Text("Parts Produced")
                .font(.title2)
                .fontWeight(.semibold)
            
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
        .padding()
    }
}

#Preview {
    BarChart()
}
