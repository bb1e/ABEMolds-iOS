//
//  DetailedReportsView.swift
//  ABEMolds
//
//  Created by Bruna Leal on 26/12/2023.
//

import SwiftUI

struct DetailedReportsView: View {
    let doughnutData: [Double] = [75, 25]
    let lineChartData: [Double] = [10, 25, 67, 30, 20, 40, 35]
    let colors: [Color] = [Color.mint, Color.orange]
    
    var item: Mold
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ScrollView {
            VStack {
                Text(item.projectName)
                    .font(.system(size: 35))
                    .bold()
                    .padding()
                    .padding(.trailing)
                
                Spacer()
                //homepage stats
                LineChart(data: lineChartData, title: "Parts Produced")
                    .frame(height: 200)
                    .padding()
                    .padding(.bottom, 130)
                Spacer()
                DonutChart()
                 .frame(width: 200, height: 200)
                 .padding()
                 Spacer()
            }
        }
    }
}

/*#Preview {
    DetailedReportsView()
}*/
