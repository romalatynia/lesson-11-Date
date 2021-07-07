//
//  Student.swift
//  Date
//
//  Created by Harbros47 on 29.12.20.
//

import Foundation
class Student {
    var dateOfBirth: Date
    var name: String
    var lastName: String
    
    init(dateOfBirth: Date, name: String, lastName: String) {
        self.dateOfBirth = dateOfBirth
        self.name = name
        self.lastName = lastName
    }
}
