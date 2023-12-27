//
//  MoldsView.swift
//  ABEMolds
//
//  Created by Bruna Leal on 15/11/2023.
//

import SwiftUI

struct MoldsView: View {
    
    var elements: [String] = ["Lego 3x8 Blocks", "6-Pin Electrical Conector", "Light Switch", "Center Console Bezel"]
    var elements2: [String] = ["4-Pin Electrical Conector", "Radio Volume Knob"]
    
    @State private var selectedItem: String = ""
    @State private var activeSheet: ActiveSheet = .none
    
    var body: some View {
        NavigationView {
            VStack {
                
                if !selectedItem.isEmpty && activeSheet == .none{
                    NavigationLink(destination: MoldDetailView(item: selectedItem, activeSheet: $activeSheet), isActive: Binding(get: { !selectedItem.isEmpty && activeSheet == .none }, set: { _ in selectedItem = "" })) { }
                } else if !selectedItem.isEmpty && activeSheet == .arView{
                    NavigationLink(destination: MoldARView(), isActive: Binding(get: { !selectedItem.isEmpty && activeSheet == .arView }, set: { _ in selectedItem = "" })) { }
                } else {
                    Text("Manage mold production")
                        .font(.system(size: 35))
                        .bold()
                        .padding()
                        .padding(.trailing, 90)
                    
                    Spacer()
                    CardSectionList(elements: elements, title: "IN PRODUCTION", selectedItem: $selectedItem)
                    CardSectionList(elements: elements2, title: "STOPPED", selectedItem: $selectedItem)
                }
            }
            .padding()
        }
    }
}

#Preview {
    MoldsView()
}
