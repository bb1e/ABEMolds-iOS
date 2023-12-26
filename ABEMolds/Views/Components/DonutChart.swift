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
    let dataPoints: [Double]
    let colors: [Color]

    var body: some View {
        ZStack {
            ForEach(0..<dataPoints.count) { index in
                Circle()
                    .trim(from: index == 0 ? 0 : CGFloat(dataPoints[0...index-1].reduce(0, +)) / 100.0,
                          to: CGFloat(dataPoints[0...index].reduce(0, +)) / 100.0)
                    .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                    .foregroundColor(colors[index])
                    .frame(width: 200, height: 200)
                    .animation(.linear)
            }
            Text("Molds in Production")
                .foregroundColor(.white)
                .font(.headline)
        }
    }
}
