//
//  MoldDetailView.swift
//  ABEMolds
//
//  Created by Bruna Leal on 25/12/2023.
//

import SwiftUI

struct MoldDetailView: View {
    
    var item: String
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack() {
                Text(item)
                    .font(.system(size: 35))
                    .bold()
                    .padding()
                    .padding(.trailing)
                //Spacer()
                Image(.image)
                Text("Status: ")
                Text("Cavity Temperature: ")
                Text("Machine: ")
                Text("Customer: ")
                Text("Production Time: ")
                
                HStack {
                    NavigationLink(destination: MoldARView()) {
                        HStack {
                            Image(systemName: "star")
                            Text("AR")
                        }
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                    }
                    
                    NavigationLink(destination: PartsControlView()) {
                        HStack {
                            Image(systemName: "star")
                            Text("Parts Control")
                        }
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                    }
                }
                
                NavigationLink(destination: DetailedReportsView(item: item)) {
                    HStack {
                        Image(systemName: "star")
                        Text("Reports")
                    }
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
                }
                
            }
        }
    }
}

#Preview {
    MoldDetailView(item: "legoooooo")
}
