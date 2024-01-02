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
    
    @Binding var molds: [Mold]
    //@Binding var chartsData: []
    
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
                PieChart()
                    .frame(width: 200, height: 200)
                    .padding()
                Spacer()
                BarChart()
                    .frame(height: 200)
                    .padding()
                    .padding(.bottom, 130)
                Spacer()
            }
        }
    }
}


