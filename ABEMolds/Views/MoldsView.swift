//
//  MoldsView.swift
//  ABEMolds
//
//  Created by Bruna Leal on 15/11/2023.
//

import SwiftUI


struct MoldsView: View {
    var manager = MoldsManager()
    @Binding var molds: [Mold]

    @State var selectedItem: String = ""
    @State var isSelected: Bool = false
    @State private var path: [Mold] = []
    
    var viewModel = MoldsViewModel()

    var body: some View {
        NavigationStack(path: $path) {
            VStack {
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
                        ForEach(molds, id: \.self) { mold in
                            if viewModel.isAvailable(mold: mold){
                                let _ = print("molds for list: \(molds.count)")
                                NavigationLink(value: mold) {
                                    Text(mold.projectName)
                                }
                            }
                        }
                    }
                    .navigationDestination(for: Mold.self) { mold in
                        MoldDetailView(item: mold)
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
                        ForEach(molds, id: \.self) { mold in
                            if !viewModel.isAvailable(mold: mold) {
                                NavigationLink(value: mold) {
                                    Text(mold.projectName)
                                }
                            }
                        }
                    }
                    .navigationDestination(for: Mold.self) { mold in
                        MoldDetailView(item: mold)
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
}
