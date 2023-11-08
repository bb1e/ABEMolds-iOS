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
                Text("Welcome to your dashboard")
                    .font(.system(size: 35))
                    .bold()
                    .padding()
                    .padding(.trailing, 90)
                //homepage stats
                }
            }
            VStack {
                Spacer()
                CustomTabBar(selectedTab: $selectedTab)
            }
        }
}

#Preview {
    ContentView()
}
