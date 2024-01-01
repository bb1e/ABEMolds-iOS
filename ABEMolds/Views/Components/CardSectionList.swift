//
//  CardSectionList.swift
//  ABEMolds
//
//  Created by Bruna Leal on 25/12/2023.
//

import SwiftUI

struct CardSectionList: View {

    //var elements: [Mold] = []
    var elements: [String] = []
    var title: String = ""
    
    //@Binding var selectedItem: Mold
    @Binding var selectedItem: String
    @Binding var isSelected: Bool

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
                            isSelected = true
                        }) {
                            Text(item /*.projectName*/)
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
