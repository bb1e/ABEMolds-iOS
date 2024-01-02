//
//  ContentView.swift
//  ABEMolds
//
//  Created by Bruna Leal on 08/11/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab: Tab = .house
    var viewModel = MoldsViewModel()
    @State var molds: [Mold] = []
    @State var chartsData = []
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        ZStack {
            VStack {
                Group {
                    if selectedTab == .leaf {
                        ReportsView(molds: $molds)
                    } else if selectedTab == .house {
                        DashboardView()
                    } else if selectedTab == .gearshape {
                        MoldsView(molds: $molds)
                    }
                }
                VStack {
                    //Spacer()
                    CustomTabBar(selectedTab: $selectedTab)
                }
            }
        }
        .onAppear {
            Task {
                molds = viewModel.getAllMolds()
                print("\n\n\n\n\n", molds)
            }
        }
    }
}

#Preview {
    ContentView()
}
