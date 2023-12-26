//
//  LineChart.swift
//  ABEMolds
//
//  Created by Bruna Leal on 14/11/2023.
//

import SwiftUI
import SwiftUICharts

struct LineChart: View {
    let data: [Double]
    let title: String

    var body: some View {
        ZStack {
            LineView(data: data, title: "", legend: "Total Downtime")
                .frame(height: 200)
            Text("")
                .foregroundColor(.black)
                .font(.headline)
        }
    }
}
