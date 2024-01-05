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
    
    var manager = MoldsManager()
    @State var isRejecting: Bool = false
    
    var body: some View {
        VStack {
            Text("Parts Control")
              .font(Font.custom("SF Pro", size: 24))
              .foregroundColor(.black)
              .frame(width: 350, alignment: .topLeading)
            Text(item.projectName)
              .font(Font.custom("SF Pro", size: 16))
              .foregroundColor(.black)
              .frame(width: 350, alignment: .topLeading)
            Text("31/10/2023 8:23")
              .font(Font.custom("SF Pro", size: 24))
              .foregroundColor(.black)
            Spacer()
            Rectangle()
              .foregroundColor(.clear)
              .frame(width: 392, height: 225)
              .background(Color(red: 0.85, green: 0.85, blue: 0.85))
            
            Text(item.currentParameters.stage)
              .font(Font.custom("SF Pro", size: 17))
              .foregroundColor(.black)
            //change this to show related to the state
            Text("Cavity Temperature: \(item.currentParameters.cavityTempC)ºC\nPlastic Temperature: \(item.currentParameters.plasticTempC)ºC\nFill Time: 3.43s\nAvg. Injection Pressure: 3.783kg/cm3")
              .font(Font.custom("SF Pro", size: 17))
              .foregroundColor(.black)
            Spacer()
            //check still
            if !item.currentParameters.isAcceptingParts && !isRejecting {
                HStack {
                    Button(action: {
                        manager.updateOverrideUser(moldId: item.id, overrideUser: true)
                        self.isRejecting = true
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
                        manager.updateOverrideUser(moldId: item.id, overrideUser: false)
                        self.isRejecting = false
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
}

