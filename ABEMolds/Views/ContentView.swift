//
//  ContentView.swift
//  ABEMolds
//
//  Created by Bruna Leal on 08/11/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab: Tab = .house
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        ZStack {
            VStack {
                Group {
                    if selectedTab == .leaf {
                        ReportsView()
                    } else if selectedTab == .house {
                        DashboardView()
                    } else if selectedTab == .gearshape {
                        MoldsView()
                    }
                }
                VStack {
                    //Spacer()
                    CustomTabBar(selectedTab: $selectedTab)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
