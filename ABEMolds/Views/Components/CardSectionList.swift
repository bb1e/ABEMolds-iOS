//
//  CardSectionList.swift
//  ABEMolds
//
//  Created by Bruna Leal on 25/12/2023.
//

import SwiftUI

struct CardSectionList: View {

    var elements: [String] = []
    var title: String = ""
    
    @Binding var selectedItem: String

    var body: some View {
        NavigationView {
            VStack {
                Text(title)
                    .font(.caption)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.gray)
                List {
                    ForEach(elements, id: \.self) { item in
                        Button(action: {
                            selectedItem = item
                        }) {
                           Text(item)
                        }
                    }
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 10)
        }
    }
}

/*#Preview {
    CardSectionList(elements: ["element 1", "element 2", "element 3"])
}*/
