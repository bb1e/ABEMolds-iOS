//
//  NavigationPath.swift
//  ABEMolds
//
//  Created by Bruna Leal on 31/12/2023.
//

import Foundation
import SwiftUI

class NavigationPath: ObservableObject {
   @Published var path: [AnyHashable] = []

   func append<T: Hashable>(_ value: T) {
       path.append(value)
   }

   func popLast() {
       path.removeLast()
   }
}
