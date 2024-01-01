//
//  MoldDetailView.swift
//  ABEMolds
//
//  Created by Bruna Leal on 25/12/2023.
//

import SwiftUI


struct MoldDetailView: View {
    
    var item: String
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack() {
                Text(item)
                    .font(.system(size: 24))
                    .frame(width: 374, alignment: .topLeading)
                //Spacer()
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
                Text("STATUS: Cooling\nCAVITY TEMPERATURE: 123ºC\nMACHINE: A12 ENGEL\nCUSTOMER: LEGO\nPRODUCTION TIME: 3h 42min 12s")
                .font(Font.custom("SF Pro", size: 20))
                .foregroundColor(.black)
                .lineSpacing(8)
                
                HStack {
                    NavigationLink (destination: MoldARView()) {
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
                    .frame(width: 366, alignment: .center)
                    .background(.blue)
                    .foregroundColor(.white)
                    .cornerRadius(14)
                }
                
            }
        }
    }
}
