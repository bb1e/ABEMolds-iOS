//
//  Mold.swift
//  ABEMolds
//
//  Created by Bruna Leal on 29/12/2023.
//

import Foundation

struct Mold: Codable {
    //var id: Int
    var currentParameters: CurrentParameters
    var dateManufactoringEnd: Date
    var dateManufactoringStart: Date
    var days: [Days]
    var manufactoringParameters: ManufactoringParameters
    var projectName: String
    var totalPartsProduced: Int
    var weeks: [Weeks]
}
