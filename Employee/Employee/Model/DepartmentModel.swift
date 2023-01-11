//
//  DepartmentModel.swift
//  Employee
//
//  Created by ramya on 09/01/23.
//

import Foundation
struct Department:Codable {
    var id: Int
    var name: String
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}
