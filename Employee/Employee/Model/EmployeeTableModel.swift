//
//  EmployeeTableModel.swift
//  Employee
//
//  Created by ramya on 09/01/23.
//

import Foundation
struct EmployeeTableModel:Codable  {
    var department : Department?
    var data : [Employee]?
//    enum CodingKeys: String, CodingKey {
//        case department = "department"
//        case data = "data"
//    }
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        let department = try values.decode(Department.self, forKey: .department)
//        let data = try values.decode([Employee].self, forKey: .data)
//
//        self.init(department: department, data: data)
//    }
    init(department: Department?, data: [Employee]?) {
        self.department = department
        self.data = data
    }
}
