//
//  MoldDetailView.swift
//  ABEMolds
//
//  Created by Bruna Leal on 25/12/2023.
//

import SwiftUI


struct MoldDetailView: View {
    
    @State var item: Mold
    @Environment(\.presentationMode) var presentationMode
    
    var viewModel = MoldsViewModel()
    @State var totalPartsByMoldPerDayChartsData: [ChartData] = []
    @State var partsQualityByMoldChartData: [ChartData] = []
    
    var body: some View {
        NavigationView {
            VStack() {
                Text(item.projectName)
                    .font(.system(size: 24))
                    .frame(width: 350, alignment: .topLeading)
                Rectangle()
                .foregroundColor(.clear)
                .frame(width: 393, height: 264.66049)
                .background(
                    Image(.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 393, height: 264.6604919433594)
                .clipped()
                )
                Text("STATUS: \(item.currentParameters.stage)\nCAVITY TEMPERATURE: \(String(format: "%.2f",item.currentParameters.cavityTempC))ºC\nMACHINE: \(item.machineName)\nCUSTOMER: \(item.customerName)\n")
                .font(Font.custom("SF Pro", size: 20))
                .foregroundColor(.black)
                .lineSpacing(8)
                .padding(.top, 20)
                
                HStack {
                    NavigationLink (destination: MoldARView(item: item)) {
                        HStack (alignment: .center, spacing: 10) {
                            Image(systemName: "arkit")
                            Text("AR")
                        }
                        .foregroundColor(.white)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 14)
                        .frame(width: 175, alignment: .center)
                        .background(Color(red: 0, green: 0.48, blue: 1))
                        .cornerRadius(14)
                    }
        
                    NavigationLink (destination: PartsControlView(item: item)) {
                        HStack (alignment: .center, spacing: 10) {
                            Image(systemName: "doc.plaintext")
                            Text("Parts Control")
                        }
                        .foregroundColor(.white)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 14)
                        .frame(width: 175, alignment: .center)
                        .background(Color(red: 0, green: 0.48, blue: 1))
                        .cornerRadius(14)
                    }
                }
                
                NavigationLink (destination: DetailedReportsView(item: item)) {
                    HStack (alignment: .center, spacing: 10) {
                        Image(systemName: "chart.pie")
                        Text("Reports")
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 14)
                    .frame(width: 360, alignment: .center)
                    .background(.blue)
                    .foregroundColor(.white)
                    .cornerRadius(14)
                }
            }
            .onAppear {
                Task {
                    self.totalPartsByMoldPerDayChartsData = viewModel.partsProducedByMoldChartData(mold: item)
                    self.partsQualityByMoldChartData = viewModel.partsQualityByMoldChartData(mold: item)
                }
            }
        }
    }
}
