//
//  PartsControlView.swift
//  ABEMolds
//
//  Created by Bruna Leal on 26/12/2023.
//

import SwiftUI

struct PartsControlView: View {
    var item: Mold
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Text("Parts Control")
              .font(Font.custom("SF Pro", size: 24))
              .foregroundColor(.black)
              .frame(width: 374, alignment: .topLeading)
            Text(item.projectName)
              .font(Font.custom("SF Pro", size: 16))
              .foregroundColor(.black)
              .frame(width: 374, alignment: .topLeading)
            Text("31/10/2023 8:23")
              .font(Font.custom("SF Pro", size: 24))
              .foregroundColor(.black)
            
            Rectangle()
              .foregroundColor(.clear)
              .frame(width: 392, height: 225)
              .background(Color(red: 0.85, green: 0.85, blue: 0.85))
            
            Text("Injection")
              .font(Font.custom("SF Pro", size: 17))
              .foregroundColor(.black)
            Text("Cavity Temperature At Start: 38.3ºC\nAvg. Plastic Temperature: 183.2ºC\nFill Time: 3.43s\nAvg. Injection Pressure: 3.783kg/cm3")
              .font(Font.custom("SF Pro", size: 17))
              .foregroundColor(.black)
            
            Text("Cooling")
              .font(Font.custom("SF Pro", size: 17))
              .foregroundColor(.black)
            Text("Cooling Time: 27s\nCavity Temp. At Start: 182.9ºC\nCavity Temp. At End: 47.3ºC")
              .font(Font.custom("SF Pro", size: 17))
              .foregroundColor(.black)
            
            HStack {
                Button(action: {
                 //code
                }) {
                    HStack (alignment: .center, spacing: 10) {
                        Image(systemName: "xmark")
                        Text("Reject")
                    }
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 14)
                    .frame(width: 175, alignment: .center)
                    .background(.red)
                    .cornerRadius(14)
                }
                
                Button(action: {
                 //code
                }) {
                    HStack (alignment: .center, spacing: 10) {
                        Image(systemName: "checkmark")
                        Text("Accept")
                    }
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 14)
                    .frame(width: 175, alignment: .center)
                    .background(.green)
                    .cornerRadius(14)
                }
            }
            
        }
    }
}

