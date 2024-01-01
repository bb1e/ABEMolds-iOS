//
//  Mold.swift
//  ABEMolds
//
//  Created by Bruna Leal on 29/12/2023.
//

import Foundation

struct Mold: Codable, Hashable {
    var id: String
    var currentParameters: CurrentParameters
    var dateManufactoringEnd: Date
    var dateManufactoringStart: Date
    var days: [Day]
    var manufactoringParameters: ManufactoringParameters
    var projectName: String
    var totalPartsProduced: Int
    var weeks: [Week]
    
    init(id: String, currentParameters: CurrentParameters, dateManufactoringEnd: Date, dateManufactoringStart: Date, days: [Day], manufactoringParameters: ManufactoringParameters, projectName: String, totalPartsProduced: Int, weeks: [Week]) {
        self.id = id
        self.currentParameters = currentParameters
        self.dateManufactoringEnd = dateManufactoringEnd
        self.dateManufactoringStart = dateManufactoringStart
        self.days = days
        self.manufactoringParameters = manufactoringParameters
        self.projectName = projectName
        self.totalPartsProduced = totalPartsProduced
        self.weeks = weeks
    }
}
