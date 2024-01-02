//
//  DashboardView.swift
//  ABEMolds
//
//  Created by Bruna Leal on 15/11/2023.
//

import SwiftUI

struct DashboardView: View {
    let doughnutData: [Double] = [30, 70]
    let lineChartData: [Double] = [10, 25, 15, 30, 20, 40, 35]
    let dates: [Int] = [12, 13, 14, 15, 16, 17, 18]
    let colors: [Color] = [Color.green, Color.yellow]
    
    var manager = MoldsManager()
    @State var molds: [Mold] = []
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Welcome to your dashboard")
                    .font(.system(size: 35))
                    .bold()
                    .padding()
                    .padding(.trailing, 90)
                
                Spacer()
                //homepage stats
                DonutChart()
                 .frame(width: 200, height: 200)
                 .padding()
                 .padding(.top)
                 Spacer()
                LineChart(data: lineChartData, title: "Line Chart")
                    .frame(height: 200)
                    .padding()
                    .padding(.bottom, 200)
                Spacer()
            }
        }
        .onAppear {
            manager.fetchMolds { fetchedMolds in
                self.molds = fetchedMolds
                //print(fetchedMolds)
            }
        }
    }
}

#Preview {
    DashboardView()
}
