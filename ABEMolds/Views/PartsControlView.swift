//
//  PartsControlView.swift
//  ABEMolds
//
//  Created by Bruna Leal on 26/12/2023.
//

import SwiftUI

struct PartsControlView: View {
    @State var item: Mold
    @State var molds: [Mold]
    
    var manager = MoldsManager()
    @State var didTap: Bool = false
    
    var body: some View {
        VStack {
            Text("Parts Control")
              .font(Font.custom("SF Pro", size: 24))
              .frame(width: 350, alignment: .topLeading)
            Text(item.projectName)
              .font(Font.custom("SF Pro", size: 16))
              .frame(width: 350, alignment: .topLeading)
            Spacer()
            Rectangle()
              .foregroundColor(.clear)
              .frame(width: 392, height: 225)
              .background(Color(red: 0.85, green: 0.85, blue: 0.85))
            
            Text(item.currentParameters.stage)
              .font(Font.custom("SF Pro", size: 17))
              .padding(.top, 30)
            Text("Cavity Temperature: \(String(format: "%.2f", item.currentParameters.cavityTempC))ºC\nPlastic Temperature: \(String(format: "%.2f",item.currentParameters.plasticTempC))ºC\nFlow: \(String(format: "%.2f",item.currentParameters.injectionFlow))\nAvg. Pressure: \(String(format: "%.2f",item.currentParameters.pressure))kg/cm3")
              .font(Font.custom("SF Pro", size: 17))
              .padding(.top, 7)
            Spacer()
            if !item.currentParameters.isAcceptingParts || (item.currentParameters.isAcceptingParts && !item.currentParameters.overrideUser) {
                HStack {
                    Button(action: {
                        manager.updateOverrideUser(moldId: item.id, isAcceptingParts: false)
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
                        manager.updateOverrideUser(moldId: item.id, isAcceptingParts: true)
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
        .onChange(of: molds) { _ in
            Task {
                await manager.fetchMold(withId: item.id) { mold in
                    item = mold ?? item
                }
            }
        }
        .onReceive(Timer.publish(every: 5, on: .main, in: .common).autoconnect()) { _ in
            Task {
                manager.observeChangesInMolds { result in
                    self.molds = result
                }
            }
        }

    }
}

