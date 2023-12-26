//
//  CustomTabBar.swift
//  ABEMolds
//
//  Created by Bruna Leal on 08/11/2023.
//

import SwiftUI

//keep track of which tab we are
enum Tab: String, CaseIterable {
    case leaf
    case house
    case gearshape
}


struct CustomTabBar: View {
    @Binding var selectedTab: Tab
    
    private var fillIcon: String {
        selectedTab.rawValue + ".fill"
    }
    
    var body: some View {
        HStack {
            ForEach(Tab.allCases, id: \.rawValue) { tab in
                Spacer()
                VStack {
                    Spacer()
                    Image(systemName: selectedTab == tab ? fillIcon : tab.rawValue)
                        .scaleEffect(tab == selectedTab ? 1.25 : 1.0)
                        .foregroundColor(selectedTab == tab ? Color(.systemBlue) : Color(.systemGray))
                        .font(.system(size: 22))
                        .onTapGesture {
                            withAnimation(.easeIn(duration: 0.1)) {
                                selectedTab = tab
                            }
                        }
                    Text(tabName(for: tab))
                }
                Spacer()
            }
        }
        .frame(width: nil, height: 60)
        .background(.thinMaterial)
    }
    
    private func tabName(for tab: Tab) -> String {
            switch tab {
            case .leaf:
                return "Reports"
            case .house:
                return "Dashboard"
            case .gearshape:
                return "Molds"
            }
        }
}

#Preview {
    CustomTabBar(selectedTab: .constant(.house))
}
