//
//  EmployeeModel.swift
//  Employee
//
//  Created by ramya on 09/01/23.
//

import Foundation
struct Employee:Codable {
    var name: String
    var departmentId:Int
    var status:Bool
    init( name: String, departmentId: Int, status: Bool) {
        self.name = name
        self.departmentId = departmentId
        self.status = status
    }
}
