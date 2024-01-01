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
    var manager = MoldsManager()
    @State var molds: [Mold] = []

    //@State var selectedItem: Mold
    @State var selectedItem: String = ""
    @State var isSelected: Bool = false
    @State private var path: [String] = []

    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                /*if isSelected {
                    
                } else {*/
                    Text("Manage mold production")
                        .font(.system(size: 35))
                        .bold()
                        .padding()
                        .padding(.trailing, 90)

                    Spacer()
                    VStack {
                        Text("IN PRODUCTION")
                            .font(.caption)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(.gray)
                        List {
                            ForEach(elements, id: \.self) { item in
                                NavigationLink(value: item) {
                                    Text(item)
                                }
                            }
                        }
                        .navigationDestination(for: String.self) { item in
                            MoldDetailView(item: item)
                        }                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 10)
                    VStack {
                        Text("STOPPED")
                            .font(.caption)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(.gray)
                        List {
                            ForEach(elements2, id: \.self) { item in
                                NavigationLink(value: item) {
                                    Text(item)
                                }
                            }
                        }
                        .navigationDestination(for: String.self) { item in
                            MoldDetailView(item: item)
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 10)
                    
                }
                
            }
            .padding()
        }
        /*.onAppear {
            manager.fetchMolds { fetchedMolds in
                self.molds = fetchedMolds
                //print(fetchedMolds)
            }
        }*/
    //}
}
